using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DetectSacrifice : MonoBehaviour
{
    public GameObject firePillar;
    public GameObject fireRing;
    public string triggerTag;
    public bool isTriggered;
    // Start is called before the first frame update
    void Start()
    {
        fireRing.SetActive(false);
        firePillar.SetActive(true);
        isTriggered = false;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        
        if (!isTriggered && (other.gameObject.tag == triggerTag))
        {
            fireRing.SetActive(true);
            firePillar.SetActive(false);
            isTriggered = true;
            other.gameObject.SetActive(false);

        }
    }
}
