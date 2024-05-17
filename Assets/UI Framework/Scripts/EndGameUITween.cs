using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EndGameUITween : MonoBehaviour
{
    [SerializeField] GameObject backpanel;
    [SerializeField] GameObject winPopup;
    [SerializeField] GameObject tickMark;

    private void Awake()
    {
        winPopup.transform.LeanScale(Vector3.zero, 0f);
        backpanel.transform.LeanScale(Vector3.zero, 0f);
        tickMark.transform.LeanScale(Vector3.zero, 0f);
        tickMark.transform.localPosition = Vector3.zero;
    }
    public void Tween()
    {
        LeanTween.scale(winPopup, new Vector3(150, 150, 150), 2f).setDelay(0.5f).setEase(LeanTweenType.easeOutElastic);

        LeanTween.scale(backpanel, new Vector3(1, 1, 1), 0.25f).setDelay(0.5f);
        LeanTween.scale(tickMark, new Vector3(150, 150, 150), 0.25f).setDelay(0.5f);

        LeanTween.moveLocal(tickMark, new Vector3(0, 525, 0), 1.75f).setDelay(0.75f).setEase(LeanTweenType.easeOutElastic);
    }
}
