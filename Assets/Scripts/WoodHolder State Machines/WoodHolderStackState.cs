using System.Linq;
using Unity.VisualScripting.FullSerializer;
using UnityEngine;

public class WoodHolderStackState : WoodHolderBaseState
{
    public override void EnterState(WoodHolderStateManager woodHolderState, WoodHolder holder)
    {
        Debug.Log("Hello from stack state");
        if(holder.cubePieces.Count == 4)
        {
            Debug.Log("Check win condition");
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

            if (!GameManager.instance.selectedChunk.chunkIdentifier.Equals(topChunkType?.chunkIdentifier))
            {
                GameManager.instance.selectedChunk.OnDeselect();
                GameManager.instance.selectedChunk = null;

                var lastSelectedHolder = GameManager.instance.lastSelectedHolder;
                lastSelectedHolder.state.SwitchState(lastSelectedHolder.state.stackState);
            }
            else
            {
                woodHolderState.SwitchState(woodHolderState.placeState);
            }
        }
    }

    public override void UpdateState(WoodHolderStateManager woodHolderState)
    {
        throw new System.NotImplementedException();
    }
}
