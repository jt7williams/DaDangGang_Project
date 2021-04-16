using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PCPlayerController : MonoBehaviour
{
    public new Camera camera;
    public GameObject body;
    public Vector3 movement;
    public Vector3 rotation;

    void Start()
    {
        
    }

    // Update is called once per frame
    void Update(){
        movement = new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical")) * 0.1f;
        rotation = new Vector3(-Input.GetAxis("Mouse Y"), Input.GetAxis("Mouse X"), 0) * 3;
    }

    private void FixedUpdate(){
        Debug.DrawLine(this.transform.position, this.transform.position + this.camera.transform.forward * 3, Color.magenta);
        Debug.DrawLine(this.body.transform.position, this.body.transform.position + this.body.transform.forward * 3, Color.yellow);

        Vector3 cameraDirection = this.camera.transform.rotation.eulerAngles;
        this.body.transform.rotation = Quaternion.Euler(new Vector3(0, cameraDirection.y, cameraDirection.z));
        
        movement = this.camera.transform.TransformDirection(movement);
        movement.y = 0;
        this.transform.position += movement;

        this.camera.transform.eulerAngles += rotation;
        
    }
}
