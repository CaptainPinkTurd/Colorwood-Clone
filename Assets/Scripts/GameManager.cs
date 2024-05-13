using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    public static GameManager instance;

    internal CubeChunk selectedChunk = null;
    internal WoodHolder lastSelectedHolder = null;
    internal const float heightDifference = 0.6f;
    internal const float maxHeight = 1.8f;
    // Start is called before the first frame update
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
