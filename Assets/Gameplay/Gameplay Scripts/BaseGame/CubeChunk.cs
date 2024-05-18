using System;
using System.Collections;
using System.Linq;
using UnityEngine;

public class CubeChunk : MonoBehaviour
{
    public CubePiece.WoodType chunkIdentifier;
    public GameObject cubeStackParent;
    private float transitionDuration = 0.125f;

    private const float heightDifference = DataManager.heightDifference;
    private const float maxHeight = DataManager.maxHeight;
    int iteratorCount = 0;

    public GameEvent onNewHolder;
    private void Start()
    {
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
    internal void OnNewHolder(WoodHolder lastSelectedHolder, WoodHolder holderParent, bool undo)
    {
        //number of n - 1 same piece currently on top
        int newStack = holderParent.cubePieces.Count - holderParent.chunkStack.Count;

        int childCountRequirement = 0;
        if(DataManager.instance.pieceNeededToRemove > 0)
        {
            //only calculate this when there's more than 0 piece needed to separate from chunk
            childCountRequirement = DataManager.instance.selectedChunk.transform.childCount - DataManager.instance.pieceNeededToRemove;
        }

        //Remove every pieces inside the chunk out of piece stack
        float addedY = 0;
        while (DataManager.instance.selectedChunk.transform.childCount > childCountRequirement)
        {
            CubePiece cubePiece = lastSelectedHolder.cubePieces.FirstOrDefault();
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
                addedY = newStack * heightDifference;

                //calculate newY based on the number of chunks and their pivot, if local y = 0 then only use addedY
                var newY = holderParent.existedType.Count >=2 ? topChunk.transform.localPosition.y + addedY : addedY;

                newY = newY <= maxHeight ? newY : maxHeight;

                //ABSOLUTELY do NOT tamper with the newZ value if u want the stack to look clean on the outside
                var newZ = topChunk.transform.localPosition.z - holderParent.cubePieces.Count - newStack;
                newZ = newZ >= -14 ? newZ : -14; 

                newPos = new Vector3(0, newY, newZ);
            }
            StartCoroutine(MoveToNewHolder(cubePiece.transform.localPosition, newPos, cubePiece, holderParent, childCountRequirement));
        }

        //Remove chunk out of stack
        lastSelectedHolder.chunkStack.Remove(DataManager.instance.selectedChunk);

        //Remove existed type in old holder
        CheckForExistType(lastSelectedHolder);

        //if there's still some pieces left after moving then place them back 
        if (transform.childCount > 0 && !undo)
        {
            OnDeselect();
        }
    }
    private IEnumerator MoveToNewHolder(Vector3 localPosition, Vector3 newPos, CubePiece piece, WoodHolder parentHolder, int childCountRequirement)
    {
        var childCount = transform.childCount;

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

        if (childCount != childCountRequirement) yield break;

        //execute these codes when there's no child left inside the old chunk

        //sort out all the new pieces added inside the new holder
        parentHolder.CubeChunkInitializer();
        parentHolder.StackingChunks();

        //destroy the old chunk and repivot the newly created chunk in the old holder
        RepivotChunk();

        //game object is the old chunk cause this code is running from the old chunk itself
        Destroy(gameObject); 

        //raise event to check for holders condition and determine new state for all of them
        onNewHolder.RaiseEvent();

        //allow player to undo again if they were undoing a piece
        GameManager.instance.undoing = false;

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
