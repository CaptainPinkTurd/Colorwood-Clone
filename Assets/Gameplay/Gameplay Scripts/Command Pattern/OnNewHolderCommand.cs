using System.Linq;
using UnityEngine;

public class OnNewHolderCommand : ICommand
{
    WoodHolder holder;
    WoodHolder oldHolder;
    int pieceMoveInOldChunk;
    public OnNewHolderCommand(WoodHolder holder)
    {
        this.holder = holder;

        oldHolder = DataManager.instance.lastSelectedHolder;
        pieceMoveInOldChunk = DataManager.instance.selectedChunk.transform.childCount  - DataManager.instance.pieceNeededToRemove;
    }
    public void Execute()
    {
        DataManager.instance.selectedChunk.OnNewHolder(oldHolder, holder, false);
    }

    public void Undo()
    {
        //Setting up variables to move chunk around
        CubeChunk topChunk = holder.chunkStack.FirstOrDefault();
        DataManager.instance.selectedChunk = topChunk;
        DataManager.instance.pieceNeededToRemove = pieceMoveInOldChunk;

        //Reposition z position of the once qualified chunk
        CubeChunk chunk = holder.chunkStack.FirstOrDefault();
        chunk.transform.localPosition = new Vector3(chunk.transform.localPosition.x, chunk.transform.localPosition.y, -5);

        //Move chunk back to previous holder
        DataManager.instance.selectedChunk.OnNewHolder(holder, oldHolder, true);

        DataManager.instance.selectedChunk = null;

        if(DataManager.instance.lastSelectedHolder != null)
        {
            //deselect current floating piece when undo
            CubeChunk selectedChunk = DataManager.instance.lastSelectedHolder.chunkStack.FirstOrDefault();
            selectedChunk.OnDeselect();
        }
    }
}
