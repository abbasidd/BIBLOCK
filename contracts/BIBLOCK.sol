// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BIBLOCK is ERC20Burnable, Ownable {
    mapping(address => bool) private _isBlacklisted;
    event AddedToBlacklist(address indexed account);
    event RemovedFromBlacklist(address indexed account);

    constructor(
        uint256 initialSupply
    ) ERC20("BIBLOCK", "BIBLOCK") Ownable(msg.sender) {
        _mint(msg.sender, initialSupply);
    }

    modifier notBlacklisted(address to, address from) {
        require(
            !_isBlacklisted[from] && !_isBlacklisted[to],
            "Address is blacklisted"
        );
        _;
    }

    function addToBlacklist(address account) public onlyOwner {
        _isBlacklisted[account] = true;
        emit AddedToBlacklist(account);
    }

    function removeFromBlacklist(address account) public onlyOwner {
        _isBlacklisted[account] = false;
        emit RemovedFromBlacklist(account);
    }

    function increaseAllowance(
        address spender,
        uint256 addedValue
    ) public returns (bool) {
        _approve(
            msg.sender,
            spender,
            allowance(msg.sender, spender) + addedValue
        );
        return true;
    }

    function decreaseAllowance(
        address spender,
        uint256 subtractedValue
    ) public returns (bool) {
        uint256 currentAllowance = allowance(msg.sender, spender);
        require(
            currentAllowance >= subtractedValue,
            "ERC20: decreased allowance below zero"
        );
        unchecked {
            _approve(msg.sender, spender, currentAllowance - subtractedValue);
        }
        return true;
    }

    function transfer(
        address recipient,
        uint256 amount
    ) public override notBlacklisted(msg.sender, recipient) returns (bool) {
        return super.transfer(recipient, amount);
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override notBlacklisted(sender, recipient) returns (bool) {
        return super.transferFrom(sender, recipient, amount);
    }

    function burn(uint256 value) public override onlyOwner {
        _burn(msg.sender, value);
    }

    function burnFrom(
        address account,
        uint256 value
    ) public override onlyOwner {
        _spendAllowance(account, msg.sender, value);
        _burn(account, value);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
