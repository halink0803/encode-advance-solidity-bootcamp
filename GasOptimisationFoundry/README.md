# GAS OPTIMSATION 

- Your task is to edit and optimise the Gas.sol contract. 
- You cannot edit the tests & 
- All the tests must pass.
- You can change the functionality of the contract as long as the tests pass. 
- Try to get the gas usage as low as possible. 



## To run tests & gas report with verbatim trace 
Run: `forge test --gas-report -vvvv`

## To run tests & gas report
Run: `forge test --gas-report`

## To run a specific test
RUN:`forge test --match-test {TESTNAME} -vvvv`
EG: `forge test --match-test test_onlyOwner -vvvv`

## Current test result
Suite result: ok. 12 passed; 0 failed; 0 skipped; finished in 1.26s (2.76s CPU time)
| src/Gas.sol:GasContract contract |                 |        |        |        |         |
|----------------------------------|-----------------|--------|--------|--------|---------|
| Deployment Cost                  | Deployment Size |        |        |        |         |
| 2659266                          | 11839           |        |        |        |         |
| Function Name                    | min             | avg    | median | max    | # calls |
| addToWhitelist                   | 34471           | 66109  | 84498  | 84726  | 2048    |
| administrators                   | 2523            | 2523   | 2523   | 2523   | 5       |
| balanceOf                        | 616             | 2044   | 2616   | 2616   | 1793    |
| balances                         | 554             | 1054   | 554    | 2554   | 1024    |
| checkForAdmin                    | 11621           | 11621  | 11621  | 11621  | 1       |
| getPaymentStatus                 | 780             | 780    | 780    | 780    | 256     |
| transfer                         | 174855          | 214979 | 217455 | 217551 | 1024    |
| whiteTransfer                    | 105200          | 105399 | 105452 | 105464 | 768     |
| whitelist                        | 598             | 598    | 598    | 598    | 512     |

## Optimized test result
Suite result: ok. 12 passed; 0 failed; 0 skipped; finished in 1.05s (2.33s CPU time)
| src/Gas.sol:GasContract contract |                 |        |        |        |         |
|----------------------------------|-----------------|--------|--------|--------|---------|
| Deployment Cost                  | Deployment Size |        |        |        |         |
| 1538792                          | 6861            |        |        |        |         |
| Function Name                    | min             | avg    | median | max    | # calls |
| addToWhitelist                   | 23954           | 45883  | 54392  | 54620  | 2048    |
| administrators                   | 2501            | 2501   | 2501   | 2501   | 5       |
| balanceOf                        | 604             | 2032   | 2604   | 2604   | 1793    |
| balances                         | 587             | 1087   | 587    | 2587   | 1024    |
| checkForAdmin                    | 11660           | 11660  | 11660  | 11660  | 1       |
| getPaymentStatus                 | 723             | 723    | 723    | 723    | 256     |
| transfer                         | 149617          | 189483 | 192229 | 192325 | 1024    |
| whiteTransfer                    | 105014          | 105212 | 105278 | 105278 | 768     |
| whitelist                        | 586             | 586    | 586    | 586    | 512     |
