// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract TRDROP is ERC20 {
    
    struct AddressAirDrop {
        address claimerAddress;
        uint256 amount;
        bool claimStatus;
    }

     constructor() ERC20("TROP", "TRD") {
    }

    bytes32 public merkleRoot=0x6ed428429100f7b4b37ab82ddede2091e8875dd2476eaa40cdebf40f8cc07d03;

    mapping(address => AddressAirDrop) addressAirdrops;
    event claimAirdrop(address owner, uint amount);

    function claimAirDrop(
        bytes32[] calldata _merkleProof,
        uint256 _itemId,
        uint256 _amount,
        address _address
    ) public {

        AddressAirDrop storage airdrop = addressAirdrops[_address];
        require(!airdrop.claimStatus, "Airdrop has been claimed");

        //verify the merfkleProof 
        bytes32 leaf = keccak256(abi.encodePacked(_address, _itemId, _amount));
        require(MerkleProof.verify(_merkleProof, merkleRoot, leaf), "Incorrect proof");
        _mint(msg.sender, _amount);
        //IERC20(0x517Fdb109AaA6A3943d9A753ECaa87Db9326078a).transfer(_address, _amount);
        emit claimAirdrop(_address, _amount);

        airdrop.claimerAddress = _address;
        airdrop.amount = _amount;
        airdrop.claimStatus = true;
    }

    function getStatus(address _address) public view returns(bool){
        AddressAirDrop storage airdrop = addressAirdrops[_address];
        return(airdrop.claimStatus);
    }
}