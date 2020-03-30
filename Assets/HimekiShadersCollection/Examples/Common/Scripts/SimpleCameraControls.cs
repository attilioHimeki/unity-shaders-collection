using UnityEngine;
using UnityEngine.EventSystems;

public class SimpleCameraControls : MonoBehaviour
{
    public float cameraSpeed = 10f;
    public float mouseSensitivity = 0.15f;

    private Vector3 lastDragPosition;
    private bool draggingMouse = false;

    void Update()
    {
        UpdateMouseDrag();
        UpdateTranslation();
    }

    private void UpdateTranslation()
    {
        Vector3 input = new Vector3(Input.GetAxis("Horizontal"), 0f, Input.GetAxis("Vertical"));
        Vector3 translation = input * cameraSpeed * Time.deltaTime;
        transform.Translate(translation);
    }

    private void UpdateMouseDrag()
    {
		var isInteractingWithUI = EventSystem.current.currentSelectedGameObject != null;
		if(!isInteractingWithUI)
		{
			var isMousePressed = Input.GetMouseButton(0);

			if (!draggingMouse && isMousePressed)
			{
				lastDragPosition = Input.mousePosition;
				draggingMouse = true;
			}
			else
			{
				if (isMousePressed)
				{
					var mouseMovement = (Input.mousePosition - lastDragPosition) * mouseSensitivity;
					var rotationAngles = new Vector3(-mouseMovement.y, mouseMovement.x, 0f);
					transform.eulerAngles = new Vector3(transform.eulerAngles.x + rotationAngles.x, transform.eulerAngles.y + rotationAngles.y, 0f);

					lastDragPosition = Input.mousePosition;
				}
				else
				{
					draggingMouse = false;
				}
			}
		}
    }

}