using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class CubeChunk : MonoBehaviour
{
    public CubePiece.WoodType chunkIdentifier;
    public GameObject cubeStackParent;

    private void Start()
    {
        //CubePiece cube = gameObject.transform.GetChild(0).GetComponent<CubePiece>();
        CubePiece cube = transform.GetComponentInChildren<CubePiece>(); 
        chunkIdentifier = cube.wood.woodType;
    }
    public void OnSelect()
    {
        Vector3 onSelectDestination = new Vector3(0, transform.localPosition.y + 0.6f, -2);
        transform.localPosition = Vector3.Lerp(transform.position, onSelectDestination, 1);
    }

    internal void OnDeselect()
    {
        Vector3 onDselectDestination = new Vector3(0, transform.localPosition.y - 0.6f, -2);
        transform.localPosition = Vector3.Lerp(transform.position, onDselectDestination, 1);
    }
    internal void OnNewHolder(WoodHolder lastSelectedHolder, WoodHolder holderParent)
    {
        CubeChunk chunkParent = GameManager.instance.selectedChunk;
        //Remove every pieces inside the chunk out of piece stack
        int newStack = 0;
        while (GameManager.instance.selectedChunk.transform.childCount != 0)
        {
            CubePiece cubePiece = chunkParent.transform.GetChild(0).GetComponent<CubePiece>();
            lastSelectedHolder.cubePieces.Remove(cubePiece); //remove cube piece out of list

            //set new parent for the removed cubePiece
            cubePiece.transform.SetParent(holderParent.transform);

            //handle the moving for each piece
            CubeChunk topChunk = holderParent.chunkStack.FirstOrDefault();
            Vector3 newPos;
            if (topChunk == null)
            {
                var newY = newStack * 0.6f;
                newPos = new Vector3(0, newY, -newStack - 1);
                newStack++;
            }
            else
            {
                newStack++;
                var addedY = newStack * 0.6f;
                var newZ = topChunk.transform.localPosition.z - newStack;
                newPos = new Vector3(0, topChunk.transform.localPosition.y + addedY, newZ);
            }
            cubePiece.transform.localPosition = newPos; 
        }

        //Remove chunk out of stack
        lastSelectedHolder.chunkStack.Remove(GameManager.instance.selectedChunk);
        lastSelectedHolder.isSelected = false;

        //Remove existed type in holder (not completed yet)
        bool canRemove = true;
        foreach(CubeChunk chunk in lastSelectedHolder.chunkStack)
        {
            if (!chunk.chunkIdentifier.Equals(chunkParent.chunkIdentifier))
            {
                continue;
            }
            else
            {
                canRemove = false;
                break;
            }
        }
        if (canRemove) lastSelectedHolder.existedType.Remove(chunkParent.chunkIdentifier);

        Destroy(chunkParent.gameObject);
    }
}
