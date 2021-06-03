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
    public GameObject target;
    public Vector3 placement;
    public GameObject highlighted;
    public MeshRenderer highlightedMeshRenderer;

    public bool leftClick;
    public bool rightClick;
    //private gameController gameController;
    public playerStats stats;
    private float playerHealth;

    //void Awake()
    //{
    //    gameController = GameObject.FindObjectOfType<gameController>();
    //}

    void Start() {
        //camera = GetComponent<Camera>();
        //inventory = new Inventory();
        placement = Vector3.zero;

        Cursor.lockState = CursorLockMode.Locked;
        Cursor.visible = false;
        playerHealth = stats.currentHealth;
    }

    void Update() {
        if(Input.GetKeyDown(KeyCode.Alpha4)) {
            selection = inventory.structures[0];
            //Instantiate(selection, this.transform.position, Quaternion.identity);
        }
        //Preview(selection, target);

        //if (Input.GetKeyDown(KeyCode.F))
        //{
        //    takePlayerDMG(10f);
        //}

        leftClick = Input.GetMouseButtonDown(2); // TODO: rename to middleClick
        rightClick = Input.GetMouseButtonDown(1);
    }

    void FixedUpdate() {
        RaycastHit hit;
        float range = 10;
        float cameraOffset = 3f;
        float previewOffset = 0.5f;
        placement = cameraTransform.position + cameraTransform.forward * cameraOffset;
        // /*
        bool placeValid = false;
        bool removeValid = false;
        if(Physics.Raycast(this.transform.position, heading.forward, out hit, range)) {
            //Debug.Log("Raycast()");
            target = hit.transform.gameObject;
            if(highlighted && target != highlighted) { highlightedMeshRenderer.material.color = Color.gray; } // no longer tracking highlighted GameObject

            if(hit.transform.gameObject.tag == "Structure") { // can Place() or Remove()
                //Debug.Log("Raycast(): Structure");
                placement = hit.point + hit.normal * previewOffset;
                placeValid = true;
                removeValid = true;

                highlighted = hit.transform.gameObject; // save reference to unhighlight GameObject later
                highlightedMeshRenderer = highlighted.GetComponent<MeshRenderer>();
                highlightedMeshRenderer.material.color = Color.yellow; // highlight removable Structure targeted
            }
            else if(hit.transform.gameObject.tag == "Terrain") { // can Place()
                //Debug.Log("Raycast(): Terrain");
                placement = hit.point + hit.normal * previewOffset;
                placeValid = true;
            }
            else if(hit.transform.gameObject.tag == "Vehicle") { // can Place()
                //Debug.Log("Raycast(): Vehicle()");
                placement = hit.point + hit.normal * previewOffset;
                placeValid = true;
            }
        }
        else {
            placement =  cameraTransform.position + cameraTransform.forward * cameraOffset; //pcCtrl.camera.transform.position + pcCtrl.camera.transform.forward * 2;
        }
        // */

        if(leftClick && preview && placeValid) { // Place Structure
            selection.Place(placement);
            //selection = null;
            //Destroy(preview);
        }
        else if(rightClick && removeValid) { // Remove Structure
            selection.Remove(target.GetComponent<IStructure>());
        }

        Preview(selection, placement, placeValid);
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
