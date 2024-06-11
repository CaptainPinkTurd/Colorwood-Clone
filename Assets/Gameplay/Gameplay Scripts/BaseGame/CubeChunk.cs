using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class CubeChunk : MonoBehaviour
{
    public EnumData.WoodType chunkIdentifier;
    public GameObject cubeStackParent;
    private float transitionDuration = 0.125f;
    List<int> layerOrder;

    [Header("Chunk Constant Variables")]
    private const float heightDifference = DataManager.heightDifference;
    private const float maxHeight = DataManager.maxHeight;
    private Vector3 ogPos;

    int iteratorCount = 0;
    public GameEvent onNewHolderState;
    private void Start()
    {
        ogPos = transform.localPosition;
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
        DataManager.instance.chunkIsMoving = false;
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
        Vector3 onSelectDestination = new Vector3(0, ogPos.y + heightDifference + 0.3f, -1);
        DataManager.instance.chunkIsMoving = true;
        StartCoroutine(LerpMovementChunk(transform.localPosition, onSelectDestination));
    }
    internal void OnDeselect()
    {
        Vector3 onDselectDestination = ogPos;
        DataManager.instance.chunkIsMoving = true;
        StartCoroutine(LerpMovementChunk(transform.localPosition, onDselectDestination));
    }
    internal void OnNewHolder(WoodHolder lastSelectedHolder, WoodHolder holderParent, bool undo)
    {
        int childCountRequirement = 0;
        if(DataManager.instance.pieceNeededToRemove > 0)
        {
            //only calculate this when there's more than 0 piece needed to separate from chunk
            childCountRequirement = DataManager.instance.selectedChunk.transform.childCount - DataManager.instance.pieceNeededToRemove;
        }

        //Remove every pieces inside the chunk out of piece stack
        int iterationCount = 0;
        layerOrder = new List<int>();
        while (DataManager.instance.selectedChunk.transform.childCount > childCountRequirement)
        {
            CubePiece cubePiece = lastSelectedHolder.cubePieces.FirstOrDefault();
            int stackOrder = 4 - lastSelectedHolder.cubePieces.Count; //4 is the max number of pieces for each holder

            lastSelectedHolder.cubePieces.Remove(cubePiece); //remove cube piece out of list

            //set new parent for the removed cubePiece
            cubePiece.transform.SetParent(holderParent.transform);

            //handle the moving for each piece
            CubeChunk topChunk = holderParent.chunkStack?.FirstOrDefault();
            Vector3 newPos;
            if (topChunk == null && holderParent.chunkStack.Count == 0)
            {
                var newY = iterationCount * heightDifference;
                newPos = new Vector3(0, newY, -1);

                layerOrder.Add(iterationCount + 1);
            }
            else
            {
                float newY = (holderParent.cubePieces.Count + iterationCount) * heightDifference;
                newY = newY <= maxHeight ? newY : maxHeight;

                newPos = new Vector3(0, newY, -1);

                layerOrder.Add(Mathf.RoundToInt(newY / heightDifference) + 1); //avoiding layer 0
            }
            iterationCount++;

            cubePiece.sprite.sortingOrder = 5; //allow the piece to be visible while moving 

            StartCoroutine(MoveToNewHolder(cubePiece.transform.localPosition, newPos, cubePiece, holderParent, childCountRequirement, stackOrder, undo));
        }
        //Remove chunk out of stack
        lastSelectedHolder.chunkStack.Remove(DataManager.instance.selectedChunk);

        //Remove existed type in old holder
        CheckForExistType(lastSelectedHolder);

        //allow player to immediately select the last holder again
        lastSelectedHolder.state.SwitchState(lastSelectedHolder.state.stackState);

        //if there's still some pieces left after moving then place them back 
        if (transform.childCount > 0 && !undo)
        {
            OnDeselect();
        }
    }
    private IEnumerator MoveToNewHolder(Vector3 localPosition, Vector3 newLocalPos, CubePiece piece, WoodHolder parentHolder, int childCountRequirement, int stackOrder, bool isUndo)
    {
        var childCount = transform.childCount;

        //cooldown for each new iteration
        float iteratorCooldown = 0.0625f;
        iteratorCooldown *= iteratorCount;
        iteratorCount++;

        yield return new WaitForSeconds(iteratorCooldown);

        //Move to new holder
        float nudgeValue = localPosition.y < 0 ? 0.9f - (localPosition.y - (heightDifference * (4 - stackOrder - 1))) : 
            GameManager.instance.canUndo ? 0.2f : 0.9f;
        //give piece a little nudge (0.9f) if it's not selected cause of undo

        piece.upParticle.Play(); //particle when moving up

        Vector3 moveUp = new Vector3(localPosition.x, localPosition.y + (heightDifference * stackOrder) + nudgeValue, -1);
        yield return StartCoroutine(LerpMovementPiece(piece.transform.localPosition, moveUp, piece));

        //player are not allow to undo while a piece is in the process of moving (putting it here is important, don't move it elsewhere)
        GameManager.instance.canUndo = false;

        Vector3 moveToX = new Vector3(0, moveUp.y, -1);
        yield return StartCoroutine(LerpMovementPiece(piece.transform.localPosition, moveToX, piece));

        piece.fallParticle.Play();

        //in case piece parent got changed to a chunk in that holder, this bug only happen when player select and place pieces down too fast
        piece.transform.SetParent(parentHolder.transform); 
        yield return StartCoroutine(LerpMovementPiece(piece.transform.localPosition, newLocalPos, piece));

        //setting layer 
        int layer = layerOrder.FirstOrDefault();
        layerOrder.Remove(layer);
        piece.sprite.sortingOrder = layer;

        if (childCount != childCountRequirement) yield break;

        //execute these codes when there's no child left inside the old chunk

        //sort out all the new pieces added inside the new holder
        parentHolder.CubeChunkInitializer();
        parentHolder.StackingChunks();

        //enable collider again if undoing cause we turn off collider when undo
        if (isUndo) parentHolder.GetComponent<Collider2D>().enabled = true;

        //destroy the old chunk and repivot the newly created chunk in the old holder
        RepivotChunk();

        //game object is the old chunk cause this code is running from the old chunk itself
        Destroy(gameObject);

        //raise event to check for holders condition and determine new state for all of them
        onNewHolderState.RaiseEvent();

        //allow player to undo again if they were undoing a piece
        GameManager.instance.canUndo = true;

        //revert conditional values to its initial state
        iteratorCount = 0;
    }

    private void RepivotChunk()
    {
        var lastSelectedHolder = transform.GetComponentInParent<WoodHolder>();

        foreach (var cubePiece in transform.GetComponentsInChildren<CubePiece>().ToList())
        {
            cubePiece.transform.SetParent(lastSelectedHolder.transform);
            lastSelectedHolder.cubePieces.Remove(cubePiece);
        }

        lastSelectedHolder.CubeChunkInitializer();
        lastSelectedHolder.StackingChunks();

        lastSelectedHolder.chunkStack.Remove(this);
    }
    private void CheckForExistType(WoodHolder lastSelectedHolder)
    {
        bool canRemove = true;
        foreach (CubeChunk chunk in lastSelectedHolder.chunkStack)
        {
            if (!chunk.chunkIdentifier.Equals(chunkIdentifier))
            {
                continue;
            }
            else
            {
                canRemove = false;
                break;
            }
        }
        if (canRemove) lastSelectedHolder.existedType.Remove(chunkIdentifier);
    }
}
