using Godot;
using System;
using System.Runtime.InteropServices;

public partial class MainWindow : Control
{
	[DllImport("dwmapi.dll", PreserveSig = false)]
	public static extern void DwmSetWindowAttribute(IntPtr hwnd, int attr, ref int attrValue, int attrSize);
	const int DWMWA_SYSTEMBACKDROP_TYPE = 38;
	const int DWMSBT_TRANSIENTWINDOW = 3;        

	public override void _Ready()
	{
		DisplayServer.WindowSetFlag(DisplayServer.WindowFlags.Transparent, true);
		GetTree().Root.TransparentBg = true;
		RenderingServer.SetDefaultClearColor(new Color(0, 0, 0, 0));
		long handleId = DisplayServer.WindowGetNativeHandle(DisplayServer.HandleType.WindowHandle);
		IntPtr hwnd = (IntPtr)handleId;
		int backdropType = DWMSBT_TRANSIENTWINDOW;
		DwmSetWindowAttribute(hwnd, DWMWA_SYSTEMBACKDROP_TYPE, ref backdropType, Marshal.SizeOf(typeof(int)));
	}
}
