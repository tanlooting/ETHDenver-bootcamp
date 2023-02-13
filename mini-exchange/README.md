# Minimum viable exchange

## Problem

This project aims to create a minimum viable exchange within a 4-days timeline.

Similar to Uniswap, the key building blocks we need here is:

- a token contract,
- an exchange contract that allows us to buy or sell specific token,
- and lastly the front-end user interface code.

Our front-end user code is placed in a separate folder called `mini-exchange-frontend`.

To improve this project, the exchange contract should accept an ERC20 interface instead and allow a separate factory contract to create a new liquidity pool (or 'Exchange') for every token pair.

## Setup

To compile contract

```
npx hardhat compile
```

```
npx hardhat test
```

To setup local node to test and deploy:

```
npx hardhat node
npx hardhat run --network hardhat deploy/01-deploy.js
```

## References:

- Dapp University: https://github.com/dappuniversity/eth_swap/
- Patrick Collin's course: https://www.youtube.com/watch?v=gyMwXuJrbJQ
- Minimum viable exchange: https://github.com/scaffold-eth/scaffold-eth-challenges/tree/challenge-4-dex
