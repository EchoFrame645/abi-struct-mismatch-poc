// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface IBUILDClaim {
    struct GlobalState {
        uint256 totalLoyalty;
        uint256 totalLoyaltyIneligible;
    }

    function getGlobalState(uint256 seasonId) external view returns (GlobalState memory);
}
