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
    [SerializeField] internal List<CubePiece.WoodType> existedType = new List<CubePiece.WoodType>(); //keep track of the type of wood in the holder

    void Awake()
    {
        CubeChunkInitializer(); //group pieces in wood holder in a singular chunk

        StackingChunks(); //stacking chunks in order

        LayerSort(chunkStack); //reposition the overlapping cube

    }

    internal void StackingChunks()
    {
        List<CubePiece.WoodType> existedChunkType = new List<CubePiece.WoodType>();
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

    internal void CubeChunkInitializer()
    {
        var list = gameObject.transform.GetComponentsInChildren<CubePiece>().ToList();
        foreach(var cubePiece in cubePieces)
        {
            //remove pieces that already existed and have their own parents
            if (cubePiece.transform.parent != null) list.Remove(cubePiece);
        }

        list.Sort((left, right) => left.transform.position.y.CompareTo(right.transform.position.y));
        list.Reverse();

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
    }

    public void LayerSort(List<CubeChunk> list) //sorting layer in order for each new piece
    {
        foreach (CubeChunk chunk in list)
        {
            int layerOrder = Mathf.RoundToInt(chunk.transform.localPosition.y / DataManager.heightDifference);
            int pieceInChunk = chunk.transform.childCount;

            for(int i = 0; i < pieceInChunk; i++)
            {
                CubePiece piece = chunk.transform.GetChild(i).GetComponent<CubePiece>();
                piece.sprite.sortingOrder = layerOrder;
                layerOrder--;
            }
        }
    }

    private void OnMouseDown()
    {
        state.currentState.OnClickEvent(state);
    }
}
