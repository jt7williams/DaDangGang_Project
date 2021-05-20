// Tandy Dang
// UCR CS179N Spring 2021

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour {
    //public PCPlayerController pcCtrl;
    public Transform cameraTransform;
    public Transform heading;
    public Inventory inventory;

    public IStructure selection;
    public GameObject preview;
    public Material previewMaterial;
    public Vector3 target;
    public bool rightClick;

    void Start() {
        //camera = GetComponent<Camera>();
        //inventory = new Inventory();
        target = Vector3.zero;
    }

    void Update() {
        if(Input.GetKeyDown(KeyCode.Alpha1)) {
            selection = inventory.structures[0];
            //Instantiate(selection, this.transform.position, Quaternion.identity);
        }
        //Preview(selection, target);

        rightClick = Input.GetMouseButtonDown(1);
    }

    void FixedUpdate() {
        RaycastHit hit;
        float range = 10;
        float cameraOffset = 2f;
        float previewOffset = 0.5f;
        target = cameraTransform.position + cameraTransform.forward * cameraOffset;
        ///*
        bool placeValid = false;
        if(Physics.Raycast(this.transform.position, heading.forward, out hit, range)) {
            //Debug.Log("Raycast()");
            if(hit.transform.gameObject.tag == "Structure") { // can Remove()
              //Debug.Log("Raycast(): Structure");
                target = hit.point + hit.normal * previewOffset;
                placeValid = true;
            }
            else if(hit.transform.gameObject.tag == "Terrain") { // can Place() or Remove()
                //Debug.Log("Raycast(): Terrain");
                target = hit.point + hit.normal * previewOffset;
                placeValid = true;
            }
            else if(hit.transform.gameObject.tag == "Vehicle") { // can Place() or Remove()
                //Debug.Log("Raycast(): Vehicle()");
                target = hit.point + hit.normal * previewOffset;
                placeValid = true;
            }
        }
        else {
            target =  cameraTransform.position + cameraTransform.forward * cameraOffset; //pcCtrl.camera.transform.position + pcCtrl.camera.transform.forward * 2;
        }
        //*/

        if(rightClick && preview && placeValid) { // Place Structure
            selection.Place(target);
            selection = null;
            Destroy(preview);
        }

        Preview(selection, target, placeValid);
    }

    void Preview(IStructure structure, Vector3 position, bool placeValid) {
        //Debug.Log("Preview()");
        if(!preview && structure) {
            Debug.Log("!preview");
            preview = Instantiate(structure.preview, position, Quaternion.identity);
            previewMaterial = preview.GetComponent<MeshRenderer>().material;
            //preview.transform.LookAt(pcCtrl.camera.transform);
        }
        else if(preview && structure) {
            Debug.Log("p&s");
            preview.transform.position = position;
            //preview.transform.LookAt(pcCtrl.camera.transform);

            if(placeValid) {
                //Debug.Log("g");
                previewMaterial.color = Color.green;
            }
            else {
                //Debug.Log("r");
                previewMaterial.color = Color.red;
            }
        }
    }
}
