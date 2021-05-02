using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DetectSacrifice : MonoBehaviour
{
    public GameObject firePillar;
    public GameObject fireRing;
    public string objectTriggerName;
    public bool isTriggered;
    // Start is called before the first frame update
    void Start()
    {
        fireRing.SetActive(false);
        firePillar.SetActive(true);
        isTriggered = false;
        objectTriggerName += " (UnityEngine.GameObject)";
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        //Debug.Log(other.gameObject.ToString());
        if (!isTriggered && (other.gameObject.ToString() == objectTriggerName))
        {
            fireRing.SetActive(true);
            firePillar.SetActive(false);
            isTriggered = true;
        }
    }
}
