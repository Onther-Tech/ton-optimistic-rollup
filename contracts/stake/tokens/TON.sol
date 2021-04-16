pragma solidity ^0.5.12;

import { Ownable } from "../../openzeppelin-contracts/contracts/ownership/Ownable.sol";
import { ERC20Mintable } from "../../openzeppelin-contracts/contracts/token/ERC20/ERC20Mintable.sol";
import { ERC20Detailed } from "../../openzeppelin-contracts/contracts/token/ERC20/ERC20Detailed.sol";
import { ERC165Checker } from "../../openzeppelin-contracts/contracts/introspection/ERC165Checker.sol";

import { SeigToken } from "./SeigToken.sol";
import { SeigManagerI } from "../interfaces/SeigManagerI.sol";

import { Abs_L2DepositedToken } from "../../optimism/Abs_L2DepositedToken.sol";

/**
 * @dev Current implementations is just for testing seigniorage manager.
 */
contract TON is Abs_L2DepositedToken, Ownable, ERC20Mintable, ERC20Detailed, SeigToken {
  constructor(address _l2CrossDomainMessenger) public 
      ERC20Detailed("Tokamak Network Token", "TON", 18) 
      Abs_L2DepositedToken(_l2CrossDomainMessenger)
  {}

  function setSeigManager(SeigManagerI _seigManager) external {
    revert("TON: TON doesn't allow setSeigManager");
  }

  function _handleInitiateWithdrawal(
        address _to,
        uint _amount
    )
        internal
    {
        _burn(msg.sender, _amount);
    }

    // When a deposit is finalized, we credit the account on L2 with the same amount of tokens.
    function _handleFinalizeDeposit(
        address _to,
        uint _amount
    )
        internal
    {
        _mint(_to, _amount);
    }
}
