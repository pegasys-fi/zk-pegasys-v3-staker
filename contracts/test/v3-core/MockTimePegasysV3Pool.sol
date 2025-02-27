// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.7.6;

import '@pegasys/v3-core/contracts/PegasysV3Pool.sol';
import '../TimeSimulator.sol';

// used for testing time dependent behavior
contract MockTimePegasysV3Pool is PegasysV3Pool {
    TimeSimulator timeSimulator;

    function setTimeSimulator(TimeSimulator _timeSimulator) external {
        timeSimulator = _timeSimulator;
    }

    function _blockTimestamp() internal view override returns (uint32) {
        return uint32(timeSimulator.blockTimestamp());
    }
}
