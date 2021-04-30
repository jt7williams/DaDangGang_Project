using UnityEngine;

public class target : MonoBehaviour
{
    public float health = 10f;
	public GameObject flesh;
	public GameObject dependency;
	public GameObject collider;
	public GameObject zombie;
	public GameObject removable;
	
    public void damageTake(float amt){
		if (dependency == null) 
		{
			health -= amt;
			if(health <= 0f){
				dead();
			}
		}
    }

    void dead(){
        GameObject meatFlap = Instantiate(flesh);
		meatFlap.transform.localPosition =  collider.transform.position; //gameObject.transform.position;
		
		Destroy(zombie);
		Destroy(removable);
		Destroy(collider.GetComponent<CapsuleCollider>());
		Destroy(meatFlap, 6.0f);
    }
}
