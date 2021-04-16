using UnityEngine;

public class GunScript : MonoBehaviour
{
    public float damage = 10f;
    public float range = 100f;
    public float fireRate = 15f;
    public float impactForce = 60f;

    public GameObject impactEffect;
    public Camera fpsCam;

    private float nextTTF = 0f;

    CursorLockMode lockMode;

    void Awake(){
        lockMode = CursorLockMode.Locked;
        Cursor.lockState = lockMode;
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetButton("Fire1") && Time.time >= nextTTF){
            nextTTF = Time.time + 1f/fireRate; 
            Shoot();
        }
    }

    void Shoot(){
        RaycastHit hit;
        if (Physics.Raycast(fpsCam.transform.position, fpsCam.transform.forward, out hit, range)){
            Debug.Log(hit.transform.name);

            target tgt = hit.transform.GetComponent<target>();
            if(tgt != null){
                tgt.damageTake(damage);
            }

            GameObject impactObject = Instantiate(impactEffect, hit.point, Quaternion.LookRotation(hit.normal));
            Destroy(impactObject, 1.5f);
        }

        if(hit.rigidbody != null){
            hit.rigidbody.AddForce(-hit.normal*impactForce);
        }

    }
}
