// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract IbeedFaucet {

    mapping(address => uint256) public balances;
    mapping(address => uint256) public lastWithdrawTime; // contagem do último saque realizado

    uint256 constant withdrawalLimit = 1 ether;
    uint256 constant withdrawalCooldown = 24 hours; // tempo para sacar novamente
    bool internal locked;

    // endereço nft ticket-pass dev
    // precisa estar na mesma rede que o contrato faucet
    address immutable IbeedNFT = 0xA74098e3398EC2f78CdA221D7ec8680e158a0cbF;

    address private _owner;

    constructor() {
        _owner = msg.sender;
    }

    // evitar ataques de drenagem de tokens
    modifier noReentrant() {
        require(!locked, "No re-entrancy");
        locked = true;
        _;
        locked = false;
    }

    modifier onlyOwner {
        require(_owner == msg.sender, "Ownable: nao e dono");
        _;
    }

    // verifica se o dev possui o nft ticket pass
    modifier hasAllow {
        require(IERC721(IbeedNFT).balanceOf(msg.sender) > 0, "nao tem permissao");
        _;
    }

    function deposit() external payable {
        require(msg.value <= 5 ether, "Voce so pode depositar ate 5 ethers");
        balances[address(this)] = msg.value;
    }

    function withdraw() external noReentrant hasAllow {
        require(balances[address(this)] <= withdrawalLimit, "Saldo insuficiente.");
        require(lastWithdrawTime[address(this)] + withdrawalCooldown <= block.timestamp, "Periodo de espera necessario.");
        payable (msg.sender).transfer(withdrawalLimit);
        balances[address(this)] -= withdrawalLimit;
        lastWithdrawTime[address(this)] = block.timestamp;        
    }
}
