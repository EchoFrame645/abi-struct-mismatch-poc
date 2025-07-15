
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract BUILDClaim {
    struct GlobalState {
        uint256 totalLoyalty;
        uint256 totalLoyaltyIneligible;
        // Simulate a future upgrade
        uint256 newField; // <-- This field gets ignored by old consumers
    }

    mapping(uint256 => GlobalState) internal s_globalStates;

    function setGlobalState(uint256 seasonId, uint256 loyalty, uint256 ineligible, uint256 newFieldValue) external {
        GlobalState storage g = s_globalStates[seasonId];
        g.totalLoyalty = loyalty;
        g.totalLoyaltyIneligible = ineligible;
        g.newField = newFieldValue;
    }

    function getGlobalState(uint256 seasonId) external view returns (GlobalState memory) {
        return s_globalStates[seasonId];
    }
}
