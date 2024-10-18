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
    uint256 private totalSupply; // cannot be updated
    uint256 private paymentCounter;
    address private contractOwner;
    mapping(address => Payment[]) private payments;
    mapping(address => uint256) public whitelist;
    mapping(address => uint256) public balances;
    address[5] public administrators;
    enum PaymentType {
        BasicPayment,
        Refund,
        Dividend,
        GroupPayment
    }

    History[] private paymentHistory; // when a payment was updated

    struct Payment {
        PaymentType paymentType;
        uint256 paymentID;
        bool adminUpdated;
        string recipientName; // max 8 characters
        address recipient;
        address admin; // administrators address
        uint256 amount;
    }

    struct History {
        uint256 lastUpdate;
        address updatedBy;
        uint256 blockNumber;
    }
    
    struct ImportantStruct {
        uint256 amount;
        uint256 valueA; // max 3 digits
        uint256 bigValue;
        uint256 valueB; // max 3 digits
        bool paymentStatus;
        address sender;
    }
    mapping(address => ImportantStruct) private whiteListStruct;

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

        for (uint256 i = 0; i < administrators.length; i++) {
            if (_admins[i] != address(0)) {
                administrators[i] = _admins[i];
                balances[_admins[i]] = 0;
                if (_admins[i] == contractOwner) {
                    balances[contractOwner] = totalSupply;
                }
                emit supplyChanged(_admins[i], totalSupply);
            }
        }
    }

    function getPaymentHistory()
        public
        view
        returns (History[] memory paymentHistory_)
    {
        return paymentHistory;
    }

    function checkForAdmin(address _user) public view returns (bool admin_) {
        bool admin = false;
        for (uint256 i = 0; i < administrators.length; i++) {
            if (administrators[i] == _user) {
                admin = true;
            }
        }
        return admin;
    }

    function balanceOf(address _user) public view returns (uint256 balance_) {
        return balances[_user];
    }

    function addHistory(address _updateAddress, bool _tradeMode)
        internal 
        returns (bool status_, bool tradeMode_)
    {
        History memory history = History(block.timestamp, _updateAddress, block.number);
        paymentHistory.push(history);
        return (true, _tradeMode);
    }

    function getPayments(address _user)
        public
        view
        returns (Payment[] memory payments_)
    {
        assembly {
            if iszero(_user) {
                revert(0, 0)
            }
        }
        return payments[_user];
    }

    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata _name
    ) public returns (bool status_) {
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
        Payment memory payment = Payment(PaymentType.BasicPayment,  ++paymentCounter, false, _name, _recipient, address(0), _amount);
        payments[sender].push(payment);
        return true;
    }

    function updatePayment(
        address _user,
        uint256 _ID,
        uint256 _amount,
        PaymentType _type
    ) public onlyAdminOrOwner {
        assembly {
            if iszero(_ID) {
                revert(0, 0)
            }
            if iszero(_amount) {
                revert(0, 0)
            }
            if iszero(_user) {
                revert(0, 0)
            }
        }

        address sender = msg.sender;

        for (uint256 i = 0; i < payments[_user].length; i++) {
            if (payments[_user][i].paymentID == _ID) {
                payments[_user][i].adminUpdated = true;
                payments[_user][i].admin = _user;
                payments[_user][i].paymentType = _type;
                payments[_user][i].amount = _amount;
                addHistory(_user, true);
                emit PaymentUpdated(
                    sender,
                    _ID,
                    _amount,
                    payments[_user][i].recipientName
                );
            }
        }
    }

    function addToWhitelist(address _userAddrs, uint256 _tier)
        public 
        onlyAdminOrOwner
    {
        if (_tier >=255) {
            revert TierTooBig();
        }

        whitelist[_userAddrs] = _tier;
        if (_tier > 3) {
            whitelist[_userAddrs] -= _tier;
            whitelist[_userAddrs] = 3;
        } else if (_tier == 1) {
            whitelist[_userAddrs] -= _tier;
            whitelist[_userAddrs] = 1;
        } else if (_tier > 0 && _tier < 3) {
            whitelist[_userAddrs] -= _tier;
            whitelist[_userAddrs] = 2;
        }
        emit AddedToWhitelist(_userAddrs, _tier);
    }

    function whiteTransfer(
        address _recipient,
        uint256 _amount
    ) public checkIfWhiteListed(msg.sender) {
        address sender= msg.sender;
        whiteListStruct[sender] = ImportantStruct(_amount, 0, 0, 0, true, msg.sender);
        if ( balances[sender] < _amount ) {
            revert NotEnoughBalance();
        }
        if (_amount <= 3) {
            revert AmountTooSmall();
        }
        uint256 whitelistAmount = whitelist[sender];
        balances[sender] -= _amount;
        balances[_recipient] += _amount;
        balances[sender] += whitelistAmount;
        balances[_recipient] -= whitelistAmount;
        
        emit WhiteListTransfer(_recipient);
    }

    function getPaymentStatus(address sender) public view returns (bool, uint256) {
        return (whiteListStruct[sender].paymentStatus, whiteListStruct[sender].amount);
    }

    receive() external payable {
        payable(msg.sender).transfer(msg.value);
    }


    fallback() external payable {
         payable(msg.sender).transfer(msg.value);
    }
}