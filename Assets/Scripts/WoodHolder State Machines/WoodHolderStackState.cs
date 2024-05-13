using System.Linq;
using Unity.VisualScripting.FullSerializer;
using UnityEngine;

public class WoodHolderStackState : WoodHolderBaseState
{
    public override void EnterState(WoodHolderStateManager woodHolderState, WoodHolder holder)
    {
        if(holder.cubePieces.Count == 4)
        {
            if(holder.existedType.Count == 1 && holder.chunkStack.Count == 1)
            {
                Debug.Log("Qualified");
            }
        }
    }

    public override void OnClickEvent(WoodHolderStateManager woodHolderState)
    {
        if (GameManager.instance.selectedChunk == null)
        {
            woodHolderState.SwitchState(woodHolderState.selectedState);
        }
        else
        {
            CubeChunk topChunkType = woodHolderState.woodHolder.chunkStack.FirstOrDefault();

            //if select a holder with the same type or a full holder
            if (!GameManager.instance.selectedChunk.chunkIdentifier.Equals(topChunkType.chunkIdentifier) ||
                woodHolderState.woodHolder.cubePieces.Count == 4)
            {
                GameManager.instance.selectedChunk.OnDeselect();
                GameManager.instance.selectedChunk = null;

                var lastSelectedHolder = GameManager.instance.lastSelectedHolder;
                lastSelectedHolder.state.SwitchState(lastSelectedHolder.state.stackState);

                woodHolderState.SwitchState(woodHolderState.selectedState);
            }
            else
            {
                woodHolderState.SwitchState(woodHolderState.placeState);
            }
        }
    }
}
