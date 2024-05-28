using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.TextCore.Text;

[System.Serializable]
public class CubePiece : MonoBehaviour
{
    [Header("Wood Property")]
    [SerializeField] public Wood wood;
    [SerializeField] CubeChunk chunkPrefab;

    [Header("Sprite/VFX")]
    [SerializeField] internal SpriteRenderer sprite;
    [SerializeField] internal TrailRenderer trail;
    [SerializeField] internal ParticleSystem upParticle;
    [SerializeField] internal ParticleSystem fallParticle;

    internal CubeChunk chunk;

    private void Start()
    {
        trail.colorGradient = SetTrailGradient(wood.color);
    }
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
            trail.colorGradient = SetTrailGradient(wood.color); 
        }
    }

    Gradient SetTrailGradient(Color newColor)
    {
        Gradient gradient = new Gradient();

        GradientColorKey[] tempColorKeys = new GradientColorKey[3];
        tempColorKeys[0] = new GradientColorKey(Color.white, 0);
        tempColorKeys[1] = new GradientColorKey(newColor, 0.5f);
        tempColorKeys[2] = new GradientColorKey(Color.white, 1);

        gradient.colorKeys = tempColorKeys;

        GradientAlphaKey[] tempAlphaKeys = new GradientAlphaKey[2];
        tempAlphaKeys[0] = new GradientAlphaKey(alpha: 0, 0);
        tempAlphaKeys[1] = new GradientAlphaKey(alpha: 1, 1);

        gradient.alphaKeys = tempAlphaKeys;

        return gradient;    
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
