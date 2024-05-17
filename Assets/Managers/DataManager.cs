using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class DataManager : MonoBehaviour
{
    public static DataManager instance;

    [SerializeField] internal CubeChunk selectedChunk = null;
    [SerializeField] internal WoodHolder lastSelectedHolder = null;
    [SerializeField] internal int pieceNeededToRemove = 0;
    [SerializeField] internal int winCountdown = 0;

    internal const float heightDifference = 0.6f;
    internal const float maxHeight = 1.8f;

    void Awake()
    {
        if(instance == null)
        {
            instance = this;
            DontDestroyOnLoad(gameObject);
        }
        else
        {
            Destroy(gameObject);
        }
    }
}
