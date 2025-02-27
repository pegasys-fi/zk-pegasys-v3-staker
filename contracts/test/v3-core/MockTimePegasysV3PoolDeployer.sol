// The copy of the @pegasys/v3-core/contracts/PegasysV3PoolDeployer.sol
// TODO: should always be up to date with the original contract
// Only differences:
// - Relative imports(path was changed)
// - Added TimeSimulator import
// - Added time simulator immutable and initialization in the constructor.
// - Updated pool implementation, added time simulator initialization.

// SPDX-License-Identifier: BUSL-1.1
pragma solidity =0.7.6;

import '@pegasys/v3-core/contracts/interfaces/IPegasysV3PoolDeployer.sol';

import './MockTimePegasysV3Pool.sol';

import '../TimeSimulator.sol';

contract MockTimePegasysV3PoolDeployer is IPegasysV3PoolDeployer {
    TimeSimulator immutable timeSimulator;

    constructor(TimeSimulator _timeSimulator) {
        timeSimulator = _timeSimulator;
    }

    struct Parameters {
        address factory;
        address token0;
        address token1;
        uint24 fee;
        int24 tickSpacing;
    }

    /// @inheritdoc IPegasysV3PoolDeployer
    Parameters public override parameters;

    /// @dev Deploys a pool with the given parameters by transiently setting the parameters storage slot and then
    /// clearing it after deploying the pool.
    /// @param factory The contract address of the Pegasys V3 factory
    /// @param token0 The first token of the pool by address sort order
    /// @param token1 The second token of the pool by address sort order
    /// @param fee The fee collected upon every swap in the pool, denominated in hundredths of a bip
    /// @param tickSpacing The spacing between usable ticks
    function deploy(
        address factory,
        address token0,
        address token1,
        uint24 fee,
        int24 tickSpacing
    ) internal returns (address pool) {
        parameters = Parameters({factory: factory, token0: token0, token1: token1, fee: fee, tickSpacing: tickSpacing});
        pool = address(new MockTimePegasysV3Pool{salt: keccak256(abi.encode(token0, token1, fee))}());
        MockTimePegasysV3Pool(pool).setTimeSimulator(timeSimulator);
        delete parameters;
    }
}
