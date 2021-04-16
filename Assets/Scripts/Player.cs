using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour
{
    public Transform heading;
    public Inventory inventory;
    void Start()
    {
        //camera = GetComponent<Camera>();
        inventory = new Inventory();
    }

    void FixedUpdate(){
        RaycastHit hit;
        float range = 10;
        if(Physics.Raycast(this.transform.position, heading.forward, out hit, range)) {
            //Debug.Log("Raycast()");
            if(hit.transform.gameObject.tag == "Structure") {
                //Debug.Log("Structure");
            }
        }
    }
    void Update()
    {
        
    }
}
