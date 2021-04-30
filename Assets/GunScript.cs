using UnityEngine;

public class GunScript : MonoBehaviour
{
    public float damage = 10f;
    public float range = 100f;
    public float fireRate = 15f;
    public float impactForce = 60f;

    public GameObject impactEffect;
	public GameObject muzzleFlash;
	public GameObject muzzleLoc;
	
	Light muzzle_Flash;
    public Camera fpsCam;
	
    private float nextTTF = 0f;

    CursorLockMode lockMode;

    void Awake(){
        lockMode = CursorLockMode.Locked;
        Cursor.lockState = lockMode;
		muzzle_Flash = muzzleFlash.GetComponent<Light> ();
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
			GameObject Flash = Instantiate(muzzleFlash, muzzleLoc.transform);
            Destroy(impactObject, 0.2f);
			Destroy(Flash, 0.05f);
        }

        if(hit.rigidbody != null){
            hit.rigidbody.AddForce(-hit.normal*impactForce);
        }

    }
}
