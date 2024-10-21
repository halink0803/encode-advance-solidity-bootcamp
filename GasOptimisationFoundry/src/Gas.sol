// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0; 

import "./Ownable.sol";


error Unauthorized();
error NotWhitelisted();
error NotPassRequire();
error NotEnoughBalance();
error RecipientNameTooLong();
error TierTooBig();
error AmountTooSmall();

contract GasContract is Ownable {
    mapping(address => uint256) public whitelist;
    mapping(address => uint256) public balances;
    address[5] public administrators;
    uint256 private immutable totalSupply; // cannot be updated
    address private immutable contractOwner;
    enum PaymentType {
        BasicPayment,
        Refund,
        Dividend,
        GroupPayment
    } 
    mapping(address => uint256) private whiteListStruct;

    event AddedToWhitelist(address userAddress, uint256 tier);

    modifier onlyAdminOrOwner() {
        address sender = msg.sender;
        if ((sender == contractOwner) || checkForAdmin(sender)) {
            _;
        } else {
            revert Unauthorized();
        }
    }

    modifier checkIfWhiteListed(address sender) {
        uint256 usersTier = whitelist[sender];
        if (usersTier == 0  || usersTier > 4)  {
            revert NotWhitelisted();
        } 
        _;
    }

    event supplyChanged(address indexed, uint256 indexed);
    event Transfer(address recipient, uint256 amount);
    event PaymentUpdated(
        address admin,
        uint256 ID,
        uint256 amount,
        string recipient
    );
    event WhiteListTransfer(address indexed);

    constructor(address[] memory _admins, uint256 _totalSupply) {
        contractOwner = msg.sender;
        totalSupply = _totalSupply;

        for (uint256 i; i < administrators.length; i++) {
            if (_admins[i] != address(0)) {
                administrators[i] = _admins[i];
                if (_admins[i] == contractOwner) {
                    balances[contractOwner] = totalSupply;
                }
                emit supplyChanged(_admins[i], totalSupply);
            }
        }
    }


    function checkForAdmin(address _user) public view returns (bool admin_) {
        for (uint256 i; i < administrators.length; i++) {
            if (administrators[i] == _user) {
                admin_ = true;
            }
        }
    }

    function balanceOf(address _user) public view returns (uint256 balance_) {
        return balances[_user];
    }

    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata _name
    ) public returns (bool) {
        address sender = msg.sender;
        if (balances[sender] < _amount) {
            revert NotEnoughBalance();
        }
        if (bytes(_name).length > 9) {
            revert RecipientNameTooLong();
        }
        balances[sender] -= _amount;
        balances[_recipient] += _amount;
        emit Transfer(_recipient, _amount);
        return true;
    }

    function addToWhitelist(address _userAddrs, uint256 _tier)
        public 
        onlyAdminOrOwner
    {
        if (_tier >=255) {
            revert TierTooBig();
        }
        whitelist[_userAddrs] = _tier > 3 ? 3 : _tier;
        emit AddedToWhitelist(_userAddrs, _tier);
    }

    function whiteTransfer(
        address _recipient,
        uint256 _amount
    ) public checkIfWhiteListed(msg.sender) {
        address sender= msg.sender;
        whiteListStruct[sender] = _amount;
        if ( balances[sender] < _amount ) {
            revert NotEnoughBalance();
        }
        if (_amount <= 3) {
            revert AmountTooSmall();
        }
        uint256 whitelistAmount = whitelist[sender];
        balances[sender] = balances[sender] - _amount + whitelistAmount;
        balances[_recipient] = balances[_recipient] + _amount - whitelistAmount;
        
        emit WhiteListTransfer(_recipient);
    }

    function getPaymentStatus(address sender) public view returns (bool, uint256) {
        return (true, whiteListStruct[sender]);
    }

}
