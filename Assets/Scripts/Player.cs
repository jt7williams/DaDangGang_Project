// Tandy Dang
// UCR CS179N Spring 2021

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour {
    public Transform heading;
    public Inventory inventory;

    public IStructure selection;

    void Start() {
        //camera = GetComponent<Camera>();
        inventory = new Inventory();
    }

    void Update() {

    }

    void FixedUpdate() {
        RaycastHit hit;
        float range = 10;
        if(Physics.Raycast(this.transform.position, heading.forward, out hit, range)) {
            Debug.Log("Raycast()");
            if(hit.transform.gameObject.tag == "Structure") {
                Debug.Log("Structure");
                // can Place() or Remove()
                Preview(selection, hit);
            }
            else if(hit.transform.gameObject.tag == "Terrain") {
                // can Place()
            }
            else if(hit.transform.gameObject.tag == "Vehicle") {
                // can Place()
            }
        }
    }

    void Preview(IStructure structure, RaycastHit hit) {
        Instantiate(structure.preview, hit.transform.position, Quaternion.identity);
    }
}
