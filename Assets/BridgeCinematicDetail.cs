using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BridgeCinematicDetail : MonoBehaviour
{

    public GameObject bridge;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private IEnumerator OnTriggerEnter(Collider other)
    {
        bridge.GetComponent<Rigidbody>().useGravity = true;
        yield return new WaitForSeconds(1);
        bridge.GetComponent<Collider>().isTrigger = false;

        Debug.Log("Inside OntriggerEnter\n");
    }
}
