// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract AIRDROP{

    bytes32 public immutable merkleRoot;
    //address ContractAddress = "0x845dA5011f60dF971025E48b831D61f0f7662674";

    struct AddressAirDrop {
        address claimerAddress;
        uint256 amount;
        bool claimStatus;
    }

    mapping(address => AddressAirDrop) addressAirdrops;
    
    event claimAirdrop(address owner, uint amount);

    constructor(bytes32 _merkleRoot){
        merkleRoot = _merkleRoot;
    }

    function addAdress(address _address, uint256 _amount) external {
        AddressAirDrop storage airdrop = addressAirdrops[_address];
        airdrop.claimerAddress = _address;
        airdrop.amount = _amount;
        airdrop.claimStatus = false;
    }


    function claimAirDrop(address _address, uint256 _amount, bytes32[] calldata _merkleProof) external{

        AddressAirDrop storage airdrop = addressAirdrops[_address];
        require(!airdrop.claimStatus, "Airdrop has been claimed");

        //verify the merkleProof.
        bytes32 node = keccak256(abi.encodePacked(msg.sender, _amount));
        require(MerkleProof.verify(_merkleProof, merkleRoot, node), "merkle proof invalid");

        airdrop.claimStatus = true;
        //IER.transfer(address, _amount);

        emit claimAirdrop(_address, _amount);
    }
}