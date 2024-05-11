using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Unity.VisualScripting;
using UnityEditor;
using UnityEngine;

[System.Serializable]
public class WoodHolder : MonoBehaviour
{
    [SerializeField] GameObject chunkStackParent;
    [SerializeField] internal List<CubePiece> cubePieces = new List<CubePiece>();
    [SerializeField] internal List<CubeChunk> chunkStack = new List<CubeChunk>();
    [SerializeField] internal List<CubePiece.WoodType> existedType = new List<CubePiece.WoodType>(); //keep track of the type of wood in the holder

    [SerializeField] internal bool isSelected;

    void Start()
    {
        CubeChunkInitializer(); //group pieces in wood holder in a singular chunk

        ZSort(cubePieces); //reposition the overlapping cube

        StackingChunks(); //stacking chunks in order
    }

    private void StackingChunks()
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

    private void CubeChunkInitializer()
    {
        var list = gameObject.transform.GetComponentsInChildren<CubePiece>().ToList();
        foreach(var cubePiece in cubePieces)
        {
            //remove pieces that already existed and have their own parents
            if (cubePiece.transform.parent != null) list.Remove(cubePiece);
        }

        list.Sort((left, right) => left.transform.position.y.CompareTo(right.transform.position.y));
        list.Reverse();

        CubePiece prevPiece = null;
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

    private void ZSort(List<CubePiece> list) //sorting z pos in order for each new piece
    {
        list.Reverse(); //reverse stack from top to bottom
        CubePiece prevPiece = null;

        foreach (var piece in list)
        {
            if (prevPiece != null && prevPiece.transform.position.z <= piece.transform.position.z)
            {
                var newZ = prevPiece.transform.localPosition.z - 1;

                //change piece local position if it's overlapping with the old piece
                piece.transform.localPosition = new Vector3(piece.transform.localPosition.x, piece.transform.localPosition.y, newZ);
            }
            prevPiece = piece;
        }
        list.Reverse(); //change it back
    }

    private void OnMouseDown()
    {
        if (chunkStack.Count == 0  && GameManager.instance.selectedChunk == null) return;

        if(GameManager.instance.selectedChunk == null)
        {
            GameManager.instance.selectedChunk = chunkStack.FirstOrDefault();
            GameManager.instance.selectedChunk.OnSelect();
            GameManager.instance.lastSelectedHolder = this;
            isSelected = true;
        }
        else
        {
            if (isSelected) //if click on the same wood holder again
            {
                GameManager.instance.selectedChunk.OnDeselect();
                GameManager.instance.selectedChunk = null;
                isSelected = false;
            }
            else //if click on a new wood holder
            {
                GameManager.instance.selectedChunk.OnNewHolder(GameManager.instance.lastSelectedHolder, this);
                GameManager.instance.lastSelectedHolder = null;
                GameManager.instance.selectedChunk = null;

                CubeChunkInitializer(); //group pieces in wood holder in a singular chunk
                StackingChunks();
            }
        }
    }
}
