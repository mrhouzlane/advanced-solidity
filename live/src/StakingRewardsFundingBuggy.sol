// SPDX-License-Identifier: GPLv3
pragma solidity ^0.8.4;

import "openzeppelin/access/Ownable.sol";
import "openzeppelin/token/ERC20/IERC20.sol";

/**
 * @title Staking Rewards Funding
 * @notice A contract that is only the rewards part of `StakingRewards`.
 * @dev The inheriting contract must call `_claim()` to check its reward since the last time the
 * same call was made. The inheriting contract must ensure no more than the returned amount is
 * used. The inheriting contract can implement any type of distribution or staking scheme.
 */
abstract contract StakingRewardsFundingBuggy is Ownable {
    uint80 public rewardRate;
    uint40 public lastUpdate;
    uint40 public periodFinish;
    uint96 public totalRewardAdded;
    uint256 public periodDuration = 1 days;
    IERC20 public immutable token;

    event RewardRemoved(uint256 reward);
    event RewardAdded(uint256 reward);
    event PeriodDurationUpdated(uint256 newDuration);

    constructor(address rewardsToken) {
        token = IERC20(rewardsToken); // deployer must ensure token reverts on failed transfers
    }

    function setPeriodDuration(uint256 newDuration) external onlyOwner {
        require(block.timestamp >= periodFinish, "ONGOING_PERIOD");
        require(newDuration >= 2 ** 16 + 1, "SHORT_PERIOD_DURATION");
        require(newDuration <= type(uint32).max, "LONG_PERIOD_DURATION");
        emit PeriodDurationUpdated(periodDuration = newDuration);
    }

    function removeReward() external onlyOwner {
        uint256 tmpPeriodFinish = periodFinish;
        uint256 leftover;
        if (tmpPeriodFinish > block.timestamp) {
            unchecked {
                leftover = (tmpPeriodFinish - block.timestamp) * rewardRate;
                totalRewardAdded -= uint96(leftover);
                periodFinish = uint40(block.timestamp);
            }
        }
        token.transfer(msg.sender, leftover);
        emit RewardRemoved(leftover);
    }

    function addReward(uint256 amount) external onlyOwner {
        uint256 tmpPeriodDuration = periodDuration;
        require(amount <= type(uint96).max, "INVALID_AMOUNT");
        unchecked {
            uint256 tmpTotalRewardAdded = totalRewardAdded;
            uint256 newTotalRewardAdded = tmpTotalRewardAdded + amount;
            require(newTotalRewardAdded <= type(uint96).max, "OVERFLOW");
            totalRewardAdded = uint96(newTotalRewardAdded);
        }
        uint256 newRewardRate;
        if (lastUpdate >= periodFinish) {
            assembly {
                newRewardRate := div(amount, tmpPeriodDuration)
            }
        } else {
            unchecked {
                uint256 leftover = (periodFinish - lastUpdate) * rewardRate;
                assembly {
                    newRewardRate := div(add(amount, leftover), tmpPeriodDuration)
                }
            }
        }
        require(newRewardRate != 0, "ZERO_REWARD_RATE");
        rewardRate = uint80(newRewardRate); // MIN_PERIOD_DURATION ensures no truncation
        unchecked {
            lastUpdate = uint40(block.timestamp);
            periodFinish = uint40(block.timestamp + tmpPeriodDuration);
        }
        token.transferFrom(msg.sender, address(this), amount);
        emit RewardAdded(amount);
    }

    function _claim() internal returns (uint256 reward) {
        reward = _pendingRewards();
        lastUpdate = uint40(block.timestamp);
    }

    function _pendingRewards() internal view returns (uint256 rewards) {
        uint256 tmpPeriodFinish = periodFinish;
        uint256 lastTimeRewardApplicable =
            tmpPeriodFinish < block.timestamp ? tmpPeriodFinish : block.timestamp;
        uint256 tmpLastUpdate = lastUpdate;
        if (lastTimeRewardApplicable > tmpLastUpdate) {
            unchecked { rewards = (lastTimeRewardApplicable - tmpLastUpdate) * rewardRate; }
        }
    }
}