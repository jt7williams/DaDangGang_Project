// Tandy Dang
// UCR CS179N Spring 2021

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour {
    public PCPlayerController pcCtrl;
    public Transform heading;
    public Inventory inventory;

    public IStructure selection;
    public GameObject preview;

    void Start() {
        //camera = GetComponent<Camera>();
        //inventory = new Inventory();
    }

    void Update() {
        if(Input.GetKeyDown(KeyCode.Alpha1)) {
            selection = inventory.structures[0];
            //Instantiate(selection, this.transform.position, Quaternion.identity);
        }
    }

    void FixedUpdate() {
        Vector3 target = Vector3.zero;
        RaycastHit hit;
        float range = 10;
        if(Physics.Raycast(this.transform.position, heading.forward, out hit, range)) {
            //Debug.Log("Raycast()");
            if(hit.transform.gameObject.tag == "Structure") {
                //Debug.Log("Raycast(): Structure");
                // can Place() or Remove()
                target = hit.point + hit.normal;
                Preview(selection, target);
            }
            else if(hit.transform.gameObject.tag == "Terrain") {
                //Debug.Log("Raycast(): Terrain");
                // can Place()
                target = hit.point + hit.normal;
                Preview(selection, target);
            }
            else if(hit.transform.gameObject.tag == "Vehicle") {
                //Debug.Log("Raycast(): Vehicle()");
                // can Place()
                target = hit.point + hit.normal;
                Preview(selection, target);
            }
        }
        else {
            target = pcCtrl.camera.transform.position + pcCtrl.camera.transform.forward * 2;
            Preview(selection, target);
        }
    }

    void Preview(IStructure structure, Vector3 position) {
        Debug.Log("Preview()");
        if(!preview && selection) {
            preview = Instantiate(structure.preview, position, Quaternion.identity);
            //preview.transform.LookAt(pcCtrl.camera.transform);
        }
        else if(preview && selection) {
            preview.transform.position = position;
            //preview.transform.LookAt(pcCtrl.camera.transform);
        }
    }
}
