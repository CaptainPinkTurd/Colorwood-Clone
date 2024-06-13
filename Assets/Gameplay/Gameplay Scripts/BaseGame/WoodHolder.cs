using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Unity.VisualScripting;
using UnityEditor;
using UnityEngine;

[System.Serializable]
public class WoodHolder : MonoBehaviour
{
    [SerializeField] internal StateManager state;

    [SerializeField] GameObject chunkStackParent;

    [SerializeField] internal List<CubePiece> cubePieces = new List<CubePiece>();
    [SerializeField] internal List<CubeChunk> chunkStack = new List<CubeChunk>();
    [SerializeField] internal List<EnumData.WoodType> existedType = new List<EnumData.WoodType>(); //keep track of the type of wood in the holder

    //a temporary list that store all the piece added to this holder, doing so will help holder be constantly updated of
    //the number of cube pieces it currently have, VERY IMPORTANT as it is NEEDED to register fast pace gameplay data
    internal List<CubePiece> tempPiecesCounter = new List<CubePiece>();
    internal void StackingChunks()
    {
        List<EnumData.WoodType> existedChunkType = new List<EnumData.WoodType>();
        var list = gameObject.transform.GetComponentsInChildren<CubeChunk>().ToList();

        foreach (var chunk in chunkStack)
        {
            //remove chunk that already existed and have their own parents
            if (chunk.transform.parent != null) list.Remove(chunk);
        }
        list.Sort((left, right) => left.transform.position.y.CompareTo(right.transform.position.y));
        list.Reverse();

        foreach (var chunk in list)
        {
            chunk.transform.SetParent(chunkStackParent.transform);
        }
        chunkStack.AddRange(list);
        chunkStack.Sort((left, right) => left.transform.position.y.CompareTo(right.transform.position.y));
        chunkStack.Reverse();
    }

    internal void CubeChunkInitializer(bool rePivot, int childToKeep = 0)
    {
        var list = gameObject.transform.GetComponentsInChildren<CubePiece>().ToList();
        foreach(var cubePiece in cubePieces)
        {
            //remove pieces that already existed and have their own chunk parents
            if (cubePiece.transform.parent != null && cubePiece.transform.parent != this.transform) list.Remove(cubePiece);

            //remove any duplication in the list in case this function got called twice when the player play the game too fast
            if (list.Contains(cubePiece)) list.Remove(cubePiece);
        }
        //this is specifically here to unregister piece that are currently moving to the holder, or else it will mess up with the position
        list.RemoveAll(piece => piece.transform.localPosition.x != 0 || piece.transform.localPosition.y >= 3 || piece.transform.localPosition.y < 0);

        list.Sort((left, right) => left.transform.position.y.CompareTo(right.transform.position.y));
        list.Reverse();

        if(childToKeep > 0) 
        {
            while(list.Count != childToKeep)
            {
                //remove everything except the piece that got left behind based on piecesToRemove condition
                list.Remove(list.First());  
            }
        }
        else
        {
            //remove everything in the list if it's currently repivoting to avoid weird bugs
            if (rePivot) list.RemoveAll(unwantedPiece => unwantedPiece);
        }

        CubePiece prevPiece = cubePieces?.FirstOrDefault();
        foreach (var piece in list)
        {
            //generate chunk if there hasn't been any objects of that type before
            if (!existedType.Exists(type => type.Equals(piece.wood.woodType)))
            {
                piece.InitializeChunk();
                existedType.Add(piece.wood.woodType);
            }
            else //if a chunk of that type has already existed
            {
                //if current piece = the last checked piece
                if (piece.wood.woodType == prevPiece?.wood.woodType)
                {
                    piece.SetChunkParent(prevPiece.chunk);
                }
                else
                {
                    piece.InitializeChunk();
                }
            }
            prevPiece = piece;
        }
        cubePieces.AddRange(list);
        cubePieces.Sort((left, right) => left.transform.position.y.CompareTo(right.transform.position.y));
        cubePieces.Reverse();

        if (list.Count < tempPiecesCounter.Count) //if the addrange are smaller than the number of tempPieceCounter currently then only remove a sufficient amount for it
        {
            for (int i = 0; i < tempPiecesCounter.Count - list.Count; i++)
            {
                tempPiecesCounter.Remove(tempPiecesCounter.First());
            }
        }
        else
        {
            tempPiecesCounter.Clear();
        }
    }
    public void ChunkStackReveal()
    {
        CubeChunk chunk = chunkStack.FirstOrDefault();
        chunk?.MysteryReveal();
    }

    public void LayerSort() //sorting layer in order for each new piece
    {
        foreach (CubeChunk chunk in chunkStack)
        {
            int layerOrder = Mathf.RoundToInt(chunk.transform.localPosition.y / DataManager.heightDifference) + 1;
            int pieceInChunk = chunk.transform.childCount;

            for(int i = 0; i < pieceInChunk; i++)
            {
                CubePiece piece = chunk.transform.GetChild(i).GetComponent<CubePiece>();
                piece.sprite.sortingOrder = layerOrder;
                layerOrder--;
            }
        }
    }
    public void MysteryCubeSetUp() //We only need to call this function once when the game begin on each level (if they are a mystery level)
    {
        foreach(CubeChunk chunk in chunkStack)
        {
            for(int i = 0; i < chunk.transform.childCount; i++)
            {
                CubePiece piece = chunk.transform.GetChild(i).GetComponent<CubePiece>();

                //Subscribe IsMystery function to mysteryEventInvoker to trigger it whenever a mystery event is supposed to happen
                chunk.mysteryEventInvoker += () => piece.IsMystery(chunk.isMystery);
            }

            chunk.MysteryLock();
        }
    }
}
