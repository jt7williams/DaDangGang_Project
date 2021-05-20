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


    void Start()
    {
        //mainCamera = Camera.main;
        weapon = GetComponentInChildren<GunScript>();
        Cursor.visible = false;
        Cursor.lockState = CursorLockMode.Locked;
    }

    // Update is called once per frame
    void Update(){
        movement = new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical")) * 0.1f;
        rotation = new Vector3(-Input.GetAxis("Mouse Y"), Input.GetAxis("Mouse X"), 0) * 3;
        
    }

    private void FixedUpdate(){
        Debug.DrawLine(this.transform.position, this.transform.position + this.mainCamera.transform.forward * 3, Color.magenta);
        Debug.DrawLine(this.body.transform.position, this.body.transform.position + this.body.transform.forward * 3, Color.yellow);

        Vector3 cameraDirection = this.mainCamera.transform.rotation.eulerAngles;
        this.body.transform.rotation = Quaternion.Euler(new Vector3(0, cameraDirection.y, cameraDirection.z));

        movement = this.mainCamera.transform.TransformDirection(movement);
        movement.y = 0;
        this.transform.position += movement;

        this.mainCamera.transform.eulerAngles += rotation;

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
