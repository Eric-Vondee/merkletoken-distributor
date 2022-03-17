// // SPDX-License-Identifier: GPL-3.0
// pragma solidity ^0.8.4;
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
//  contract Airdrop{
//     IERC20 Jupiter;
//     bytes32 merkleRoot;
//     mapping(address => AddressAirdrop) addressAirdrops;
//     address JupiterAddress = 0x105F2f45e6fAf2eCb0D102fA53d1106C70d3EA77;
//     struct AddressAirdrop {
//     bool claimed;
// }
//     event AddressClaim(address owner, uint amount);
//     constructor(bytes32 _merkleRoot){
//         Jupiter = IERC20(JupiterAddress);
//         merkleRoot = _merkleRoot;
//     }

//    function claimAirdrops(
//         uint256 _amount,
//         bytes32[] calldata _merkleProof
//     ) external {
//         AddressAirdrop storage drop = addressAirdrops[msg.sender];
//         require(!drop.claimed, "Airdrop has been claimed");
//         // Verify the merkle proof.
//         bytes32 node = keccak256(abi.encodePacked(msg.sender, _amount));
//         require(MerkleProof.verify(_merkleProof, merkleRoot, node), "MerkleDistributor: Invalid proof.");

//         // Mark it claimed and send the token.
//         drop.claimed = true;
//         Jupiter.transfer(msg.sender, _amount);
//         //only emit when successful
//         emit AddressClaim( msg.sender, _amount);
//     }
//     function checkTokenBalance () public view returns (uint256){
//         return Jupiter.balanceOf(address(this));
//     }
//  }