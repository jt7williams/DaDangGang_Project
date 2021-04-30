// Tandy Dang
// UCR CS179N Spring 2021

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PCPlayerController : MonoBehaviour {
    public new Rigidbody rigidbody;
    public new Camera camera;
    public GameObject body;

    public Vector3 movement;
    public Vector3 rotation;
    public bool jump;

    public float timer;
    float oldX;
    public float jumpTimer;
    public float jumpMax;

    void Start(){
        rotation = Vector3.zero;
        timer = 0;
        oldX = 0;
        jump = false;
        jumpTimer = 0;
        jumpMax = 0.25f;
    }

    // Update is called once per frame
    void Update(){
        if (timer > 1) {
            movement = new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical")) * 0.1f;
            rotation = new Vector3(-Input.GetAxis("Mouse Y"), Input.GetAxis("Mouse X"), 0) * 3;
            jump = Input.GetAxis("Jump") != 0 ? true : false;
        }
    }

    private void FixedUpdate(){
        if (timer < 1) {
            timer += Time.fixedDeltaTime;
        }

        Debug.DrawLine(this.transform.position, this.transform.position + this.camera.transform.forward * 3, Color.magenta);
        Debug.DrawLine(this.body.transform.position, this.body.transform.position + this.body.transform.forward * 3, Color.yellow);

        // Movement
        movement = this.camera.transform.TransformDirection(movement);
        movement.y = 0;
        this.transform.position += movement;
        //this.rigidbody.AddRelativeForce(movement * 100);

        // Body Rotation
        this.body.transform.eulerAngles += new Vector3(0, rotation.y, 0); // turn left/right

        // Camera Rotation
        Vector3 cameraDirection = this.camera.transform.rotation.eulerAngles;
        float cameraRotationX = cameraDirection.x + rotation.x; // Camera rotation

        float deadzone = 5; // deadzone is 5 degrees
        if ((cameraRotationX > 270 + deadzone && cameraRotationX < 360) || (cameraRotationX > 0 && cameraRotationX < 90 - deadzone)) { // in range
            oldX = cameraRotationX;
        }
        if (cameraRotationX < 270 + deadzone && cameraRotationX > 90 - deadzone) { // out of range
            cameraRotationX = oldX;
        }
        this.camera.transform.eulerAngles = new Vector3(cameraRotationX, this.camera.transform.eulerAngles.y, this.camera.transform.eulerAngles.z);
        //Debug.Log("cameraRotationX: " + cameraRotationX);
        //Debug.Log("x: " + rotation.x + " y: " + rotation.y + " z: " + rotation.z);
        //Debug.Log("x: " + cameraDirection.x + " y: " + cameraDirection.y + " z: " + cameraDirection.z);

        // Jump
        if (jump && jumpTimer < jumpMax) {
            this.rigidbody.AddRelativeForce(new Vector3(0, 25, 0));
            jumpTimer += Time.fixedDeltaTime;
        }
        if (!jump && jumpTimer >= jumpMax) { jumpTimer = 0; } // reset jumpTimer
    }
}
