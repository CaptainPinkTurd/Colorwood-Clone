using System;
using System.Linq;
using Unity.VisualScripting.FullSerializer;
using UnityEngine;

public class StackState : IWoodHolderState
{
    public void EnterState(StateManager woodHolderState, WoodHolder holder)
    {
        if (holder.cubePieces.Count == 0) woodHolderState.SwitchState(woodHolderState.emptyState);

        if (holder.cubePieces.Count == 4)
        {
            if (holder.existedType.Count == 1 && holder.chunkStack.Count == 1)
            {
                woodHolderState.SwitchState(woodHolderState.qualifiedState);
            }
        }
    }

    public void OnClick(StateManager woodHolderState)
    {
        if (DataManager.instance.selectedChunk == null)
        {
            if (DataManager.instance.chunkIsMoving) return; //prevent spamming on the holder, it will offset the selected chunk pos if spam enough

            woodHolderState.SwitchState(woodHolderState.selectedState);
        }
        else
        {
            CubeChunk topChunkType = woodHolderState.woodHolder.chunkStack.FirstOrDefault();

            //if select a holder with a different type on top or a full holder
            if (!DataManager.instance.selectedChunk.chunkIdentifier.Equals(topChunkType.chunkIdentifier) ||
                woodHolderState.woodHolder.cubePieces.Count == 4)
            {
                DataManager.instance.selectedChunk.OnDeselect();
                DataManager.instance.selectedChunk = null;

                var lastSelectedHolder = DataManager.instance.lastSelectedHolder;
                lastSelectedHolder.state.SwitchState(lastSelectedHolder.state.stackState);

                woodHolderState.SwitchState(woodHolderState.selectedState);
            }
            else
            {
                var holder = woodHolderState.woodHolder;

                int piecesInChunk = holder.chunkStack.FirstOrDefault().transform.childCount;
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
                    DataManager.instance.pieceNeededToRemove = holder.cubePieces.Count >= 3 ? 1 
                        : Mathf.Abs(piecesInSelectedChunk - piecesInChunk);
                }  
                else if(totalPieces < 4 && holder.cubePieces.Count >= 3)
                {
                    //if holder is 1 piece  away from being filled then you either move only 1 piece from selected chunk or move the entire chunk
                    //(which consist only 1 piece)
                    DataManager.instance.pieceNeededToRemove = piecesInSelectedChunk > piecesInChunk ? 1 : 0;
                }

                woodHolderState.SwitchState(woodHolderState.placeState);
            }
        }
    }
}
