using UnityEngine;

public class WoodHolderPlaceState : WoodHolderBaseState
{
    public override void EnterState(WoodHolderStateManager woodHolderState, WoodHolder holder)
    {
        GameManager.instance.selectedChunk.OnNewHolder(GameManager.instance.lastSelectedHolder, holder);
        GameManager.instance.lastSelectedHolder = null;
        GameManager.instance.selectedChunk = null;

        holder.CubeChunkInitializer(); //group pieces in wood holder in a singular chunk
        holder.StackingChunks();

        woodHolderState.SwitchState(woodHolderState.stackState);
    }

    public override void OnClickEvent(WoodHolderStateManager woodHolderState)
    {
        
    }

    public override void UpdateState(WoodHolderStateManager woodHolderState)
    {
        
    }
}
