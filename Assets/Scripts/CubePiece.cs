using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.Events;

[System.Serializable]
public class CubePiece : MonoBehaviour
{
    public enum WoodType
    {
        Yellow,
        Blue,
        Purple,
        Red,
        Green,
        Lime,
        Cyan,
        Pink,
        Orange
    };
    [SerializeField] public Wood wood;
    [SerializeField] internal SpriteRenderer sprite;
    [SerializeField] CubeChunk chunkPrefab;

    internal CubeChunk chunk;

    internal void InitializeChunk()
    {
        chunk = Instantiate(chunkPrefab, transform.position, Quaternion.identity, transform.parent);
        chunk.name = wood.name + " Chunk";
        transform.SetParent(chunk.transform);
    }
    internal void SetChunkParent(CubeChunk chunk)
    {
        this.chunk = chunk;
        transform.SetParent(chunk.transform);
    }
    public void OnWoodChange() 
    {
        //Allow updates on wood type in edit mode
        if (wood != null)
        {
            sprite.sprite = wood.woodSprite;
            gameObject.name = wood.name;
        }
    }
#if UNITY_EDITOR
    private void OnValidate() => UnityEditor.EditorApplication.delayCall += _OnValidate;

    private void _OnValidate()
    {
        UnityEditor.EditorApplication.delayCall -= _OnValidate;
        if (this == null) return;
        OnWoodChange();
    }
#endif
}
