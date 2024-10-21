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
Suite result: ok. 12 passed; 0 failed; 0 skipped; finished in 1.28s (2.60s CPU time)
| src/Gas.sol:GasContract contract |                 |       |        |       |         |
|----------------------------------|-----------------|-------|--------|-------|---------|
| Deployment Cost                  | Deployment Size |       |        |       |         |
| 713381                           | 3255            |       |        |       |         |
| Function Name                    | min             | avg   | median | max   | # calls |
| addToWhitelist                   | 21806           | 39496 | 45340  | 45566 | 2048    |
| administrators                   | 2523            | 2523  | 2523   | 2523  | 5       |
| balanceOf                        | 593             | 2021  | 2593   | 2593  | 1793    |
| balances                         | 531             | 1031  | 531    | 2531  | 1024    |
| checkForAdmin                    | 11615           | 11615 | 11615  | 11615 | 1       |
| getPaymentStatus                 | 681             | 681   | 681    | 681   | 256     |
| transfer                         | 28981           | 51449 | 51687  | 51789 | 1024    |
| whiteTransfer                    | 75474           | 75657 | 75726  | 75726 | 768     |
| whitelist                        | 530             | 530   | 530    | 530   | 512     |
