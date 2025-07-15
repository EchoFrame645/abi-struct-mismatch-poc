// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "./interfaces/IBUILDClaim.sol";

contract BUILDFactory {
    IBUILDClaim public claim;

    constructor(address _claim) {
        claim = IBUILDClaim(_claim);
    }

    function getRefundableLoyalty(uint256 seasonId) public view returns (uint256) {
        IBUILDClaim.GlobalState memory state = claim.getGlobalState(seasonId);
        return state.totalLoyalty - state.totalLoyaltyIneligible;
    }
}
