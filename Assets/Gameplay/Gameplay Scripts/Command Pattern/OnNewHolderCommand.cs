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
        pieceMoveInOldChunk = DataManager.instance.pieceNeededToRemove == 0 ? DataManager.instance.selectedChunk.transform.childCount : DataManager.instance.pieceNeededToRemove;
    }
    public void Execute()
    {
        DataManager.instance.selectedChunk.OnNewHolder(oldHolder, holder, false);
        GameManager.instance.OnNewHolderEvent(); //reduce move countdown
    }

    public void Undo()
    {
        //Setting up variables to move chunk around
        CubeChunk topChunk = holder.chunkStack.FirstOrDefault();
        DataManager.instance.selectedChunk = topChunk;
        DataManager.instance.pieceNeededToRemove = pieceMoveInOldChunk;

        //Reposition z position of the once qualified chunk
        CubeChunk chunk = holder.chunkStack.FirstOrDefault();
        int pieceInChunk = chunk.transform.childCount;

        for (int i = 0; i < pieceInChunk; i++)
        {
            CubePiece piece = chunk.transform.GetChild(i).GetComponent<CubePiece>();
            piece.sprite.color = Color.white;
        }

        var lastSelectedHolder = DataManager.instance?.lastSelectedHolder;

        if (lastSelectedHolder != null && lastSelectedHolder.state.currentState == lastSelectedHolder.state.selectedState)
        {
            //deselect current floating piece when undo
            CubeChunk selectedChunk = DataManager.instance.lastSelectedHolder.chunkStack.FirstOrDefault();
            selectedChunk.OnDeselect();
        }

        //Move chunk back to previous holder
        oldHolder.GetComponent<Collider2D>().enabled = false;
        DataManager.instance.selectedChunk.OnNewHolder(holder, oldHolder, true);

        DataManager.instance.selectedChunk = null;

    }
}
