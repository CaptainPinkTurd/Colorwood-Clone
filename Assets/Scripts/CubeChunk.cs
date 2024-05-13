using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.ExceptionServices;
using Unity.Burst;
using UnityEngine;
using UnityEngine.WSA;

public class CubeChunk : MonoBehaviour
{
    public CubePiece.WoodType chunkIdentifier;
    public GameObject cubeStackParent;
    private float transitionDuration = 0.125f;

    private const float heightDifference = GameManager.heightDifference;
    private const float maxHeight = GameManager.maxHeight;
    int iteratorCount = 0;
    private void Start()
    {
        //CubePiece cube = gameObject.transform.GetChild(0).GetComponent<CubePiece>();
        CubePiece cube = transform.GetComponentInChildren<CubePiece>(); 
        chunkIdentifier = cube.wood.woodType;
    }
    IEnumerator LerpMovementChunk(Vector3 localPos, Vector3 destination)
    {
        float timeElapsed = 0;
        while(timeElapsed < transitionDuration)
        {
            float t = timeElapsed / transitionDuration;
            
            transform.localPosition = Vector3.Lerp(localPos, destination, t);
            timeElapsed += Time.deltaTime;

            yield return null;
        }
        transform.localPosition = destination;
    }
    IEnumerator LerpMovementPiece(Vector3 localPos, Vector3 destination, CubePiece piece)
    {
        float timeElapsed = 0;
        while(timeElapsed < transitionDuration)
        {
            float t = timeElapsed / transitionDuration;
            
            piece.transform.localPosition = Vector3.Lerp(localPos, destination, t);
            timeElapsed += Time.deltaTime;

            yield return null;
        }
        piece.transform.localPosition = destination;
    }
    public void OnSelect()
    {
        Vector3 onSelectDestination = new Vector3(0, transform.localPosition.y + heightDifference + 0.3f, transform.localPosition.z);
        StartCoroutine(LerpMovementChunk(transform.localPosition, onSelectDestination));
    }

    internal void OnDeselect()
    {
        Vector3 onDselectDestination = new Vector3(0, transform.localPosition.y - heightDifference - 0.3f, transform.localPosition.z);
        StartCoroutine(LerpMovementChunk(transform.localPosition, onDselectDestination));
    }
    internal void OnNewHolder(WoodHolder lastSelectedHolder, WoodHolder holderParent)
    {
        CubeChunk chunkParent = GameManager.instance.selectedChunk;
        //Remove every pieces inside the chunk out of piece stack

        //number of n - 1 same piece currently on top
        int newStack = holderParent.cubePieces.Count - holderParent.chunkStack.Count;

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
                var newY = newStack * heightDifference;
                newPos = new Vector3(0, newY, -newStack - 1);
                newStack++;
            }
            else
            {
                newStack++;
                var addedY = newStack * heightDifference;
                var newY = topChunk.transform.localPosition.y + addedY;
                newY = newY <= maxHeight ? newY : maxHeight;

                //ABSOLUTELY do NOT tamper with the newZ value if u want the stack to look clean on the outside
                var newZ = topChunk.transform.localPosition.z - holderParent.cubePieces.Count - newStack;

                newPos = new Vector3(0, newY, newZ);
            }
            StartCoroutine(MoveToNewHolder(cubePiece.transform.localPosition, newPos, cubePiece, holderParent, chunkParent));
        }
        
        //Remove chunk out of stack
        lastSelectedHolder.chunkStack.Remove(GameManager.instance.selectedChunk);

        //Change last holder state based on condition
        if(lastSelectedHolder.cubePieces.Count == 0)
        {
            lastSelectedHolder.state.SwitchState(lastSelectedHolder.state.emptyState);
        }
        else
        {
            lastSelectedHolder.state.SwitchState(lastSelectedHolder.state.stackState);
        }

        //Remove existed type in holder
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
    }

    private IEnumerator MoveToNewHolder(Vector3 localPosition, Vector3 newPos, CubePiece piece, WoodHolder parentHolder, CubeChunk chunkParent)
    {
        var childCount = chunkParent.transform.childCount;

        //cooldown for each new iteration
        float iteratorCooldown = 0.0625f;
        iteratorCooldown *= iteratorCount;
        iteratorCount++;

        yield return new WaitForSeconds(iteratorCooldown);

        //Move to new holder
        Vector3 moveUp = new Vector3(localPosition.x, maxHeight + heightDifference + 0.3f, localPosition.z);
        yield return StartCoroutine(LerpMovementPiece(piece.transform.localPosition, moveUp, piece));

        Vector3 moveToX = new Vector3(0, maxHeight + heightDifference + 0.3f, localPosition.z);
        yield return StartCoroutine(LerpMovementPiece(piece.transform.localPosition, moveToX, piece));

        yield return StartCoroutine(LerpMovementPiece(piece.transform.localPosition, newPos, piece));

        if (childCount != 0) yield break;

        //execute these codes when there's no child left inside the old chunk

        //sort out all the new pieces added inside the new holder
        parentHolder.CubeChunkInitializer();
        parentHolder.StackingChunks();

        //destroy the old chunk inside the old holder
        Destroy(chunkParent.gameObject);

        //revert conditional values to its initial state
        iteratorCount = 0;
    }
}
