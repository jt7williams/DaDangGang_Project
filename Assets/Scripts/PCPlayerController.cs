// Tandy Dang
// UCR CS179N Spring 2021

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PCPlayerController : MonoBehaviour
{
    public Camera mainCamera;
    public GameObject body;
    public Vector3 movement;
    public Vector3 rotation;

    public Transform player;
    GunScript weapon;

	public float timer;
	
    void Start()
    {
        rotation = Vector3.zero;
		timer = 0;
        weapon = GetComponentInChildren<GunScript>();
        Cursor.visible = false;
        Cursor.lockState = CursorLockMode.Locked;
    }

    void Update(){
        movement = new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical")) * 0.1f;
        rotation = new Vector3(-Input.GetAxis("Mouse Y"), Input.GetAxis("Mouse X"), 0) * 3;
        
    }

    private void FixedUpdate(){
		if(timer < 1) {
            timer += Time.fixedDeltaTime;
        }
        Debug.DrawLine(this.transform.position, this.transform.position + this.mainCamera.transform.forward * 3, Color.magenta);
        Debug.DrawLine(this.body.transform.position, this.body.transform.position + this.body.transform.forward * 3, Color.yellow);

        Vector3 cameraDirection = this.mainCamera.transform.rotation.eulerAngles;
        this.body.transform.rotation = Quaternion.Euler(new Vector3(0, cameraDirection.y, cameraDirection.z));

        movement = this.mainCamera.transform.TransformDirection(movement);
        movement.y = 0;
        this.transform.position += movement;

        this.mainCamera.transform.eulerAngles += rotation;
        this.body.transform.rotation = Quaternion.Euler(new Vector3(0, cameraDirection.y, cameraDirection.z)); // Body rotation

        float deadzone = 5;
        if (cameraDirection.x > 270 && cameraDirection.x < 270 + deadzone) { // upper pitch between 360 and 270 degrees, deadzone the last portion
            //Debug.Log("Upper");
            if(rotation.x < 0) { // camera trying to pitch up
                //Debug.Log("pitching up");
                rotation.x = 0;
            }
        }
        else if(cameraDirection.x < 90 && cameraDirection.x > 90 - deadzone) { // lower pitch between 0 and 90 degrees, deadzone the last portion
            //Debug.Log("Lower");
            if (rotation.x > 0) { // camera trying to pitch down
                //Debug.Log("pitching down");
                rotation.x = 0;
            }
        }
        this.mainCamera.transform.eulerAngles += new Vector3(rotation.x, rotation.y, rotation.z); // Camera rotation
    }


    //private void LateUpdate()
    //{
    //    if (Input.GetButton("Fire1"))
    //    {
    //        weapon.StartFiring();
    //    }
    //    if (weapon.isFiring)
    //    {
    //        weapon.UpdateFiring(Time.deltaTime);
    //    }
    //    weapon.UpdateBullets(Time.deltaTime);
    //    if (Input.GetButtonUp("Fire1"))
    //    {
    //        weapon.StopFiring();
    //    }
    //}
}
