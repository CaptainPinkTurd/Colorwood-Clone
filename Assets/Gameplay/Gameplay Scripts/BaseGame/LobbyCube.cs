using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class LobbyCube : MonoBehaviour
{
    private void OnEnable()
    {
        transform.DOLocalMoveY(1f, 0.25f);
        transform.DOLocalRotate(new Vector3(0, 0, 360), 0.5f, RotateMode.FastBeyond360);
        transform.DOLocalMoveY(0, 0.25f).SetDelay(0.2f);
    }
    public void DisableEvent()
    {
        transform.DOLocalMoveY(-0.5f, 0.2f);
        transform.DOLocalRotate(new Vector3(90f, 0, -360f), 0.2f, RotateMode.FastBeyond360).OnComplete(DisableGameObject);
    }
    private void DisableGameObject()
    {
        this.gameObject.SetActive(false);
    }
}
