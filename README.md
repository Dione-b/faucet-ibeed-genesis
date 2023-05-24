# Projeto Faucet Dev para comunidade Ibeed

O projeto tem o objetivo de facilitar futuros desenvolvimentos em blockchain, facilitando a requisição de ethers de teste utilizando de uma faucet exclusiva da comunidade ibeed.

## Regra de negócio do contrato

O contrato possui duas funções, uma para depósito e outra para saque, porém apenas devs que possui uma NFT estilo ticket pass poderam requisitar os ethers do faucet.

### Modifier de filtro NFT

```shell
    modifier hasAllow {
        require(IERC721(IbeedNFT).balanceOf(msg.sender) > 0, "nao tem permissao");
        _;
    }
```
