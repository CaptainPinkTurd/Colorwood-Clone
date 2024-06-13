using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class PlaceState : IWoodHolderState
{
    NewHolderInvoker newHolderInvoker;
    EnumData.WoodType currentWoodEnter; //the wood type of the wood that got placed in for a brief moment
    int numberOfPieceEntered; //the number of piece entered from the selected chunk

    //keep check of the number of chunk currently moving to keep track of the place state of the holder 
    internal int currentChunkMoving;
    public void EnterState(StateManager woodHolderState, WoodHolder holder)
    {
        currentWoodEnter = DataManager.instance.selectedChunk.chunkIdentifier;
        numberOfPieceEntered = DataManager.instance.selectedChunk.transform.childCount;

        newHolderInvoker = GameManager.instance.newHolderInvoker;

        ICommand newHolderCommand = new OnNewHolderCommand(holder);
        newHolderInvoker.AddCommand(newHolderCommand);

        //Check if there are any mystery cubes needed to reveal in the last holder
        DataManager.instance.lastSelectedHolder.ChunkStackReveal();

        DataManager.instance.lastSelectedHolder = null;
        DataManager.instance.selectedChunk = null;
    }
    public void OnClick(StateManager woodHolderState) //click event only happen when there's a selected cube waiting to be place in the holder
    {
        if (DataManager.instance.selectedChunk != null)
        {
            var holder = woodHolderState.woodHolder;
            CubeChunk topChunkType = woodHolderState.woodHolder.chunkStack.FirstOrDefault();

            Debug.Log("Onclick event from place state");
            if (!DataManager.instance.selectedChunk.chunkIdentifier.Equals(currentWoodEnter) ||
                holder.cubePieces.Count + numberOfPieceEntered == 4)
            {
                DataManager.instance.selectedChunk.OnDeselect();
                DataManager.instance.selectedChunk = null;

                var lastSelectedHolder = DataManager.instance.lastSelectedHolder;
                lastSelectedHolder.state.SwitchState(lastSelectedHolder.state.stackState);
            }
            else
            {
                int piecesInChunk; //number of piece in the chunk that just entered

                //in case there's a top chunk on the holder and it's the same type as the entered piece
                if (topChunkType != null && topChunkType.chunkIdentifier == currentWoodEnter)
                {
                    piecesInChunk = numberOfPieceEntered + topChunkType.transform.childCount;
                }
                else
                {
                    piecesInChunk = numberOfPieceEntered; 
                }

                int piecesInSelectedChunk = DataManager.instance.selectedChunk.transform.childCount;
                int totalPieces = piecesInChunk + piecesInSelectedChunk;
                DataManager.instance.pieceNeededToRemove = 0;

                //Check if needed to separate pieces from chunk when picking the target holder or not
                if (totalPieces > 4)
                {
                    //Don't change anything please
                    DataManager.instance.pieceNeededToRemove = piecesInSelectedChunk > piecesInChunk && holder.existedType.Count == 1
                        ? 2 : piecesInSelectedChunk == piecesInChunk ? 1 : Mathf.Abs(piecesInSelectedChunk - piecesInChunk);
                }
                else if (totalPieces == 4 && holder.existedType.Count >= 2)
                {
                    //if each side has 2 pieces of the same type then only move 1 piece 
                    DataManager.instance.pieceNeededToRemove = holder.cubePieces.Count + numberOfPieceEntered >= 3 ? 1 //offset cubePieces count by adding the number of piece that got registered as entered
                        : Mathf.Abs(piecesInSelectedChunk - piecesInChunk);
                }
                else if (totalPieces < 4 && holder.cubePieces.Count + numberOfPieceEntered >= 3) //offset cubePieces count by adding the number of piece that got registered as entered
                {
                    //if holder is 1 piece  away from being filled then you either move only 1 piece from selected chunk or move the entire chunk
                    //(which consist only 1 piece)
                    DataManager.instance.pieceNeededToRemove = piecesInSelectedChunk > piecesInChunk ? 1 : 0;
                }

                currentChunkMoving++;
                woodHolderState.SwitchState(woodHolderState.placeState);
            }
        }
    }
}
