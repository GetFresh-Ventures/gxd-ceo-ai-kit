import os
import sys
import unittest
from unittest.mock import patch, MagicMock

# Add tools dir to path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'tools')))
import importlib

# Dynamic import since hyphen in module name
gfv_auth = importlib.import_module("gfv-auth")

class TestAuthGateway(unittest.TestCase):
    
    @patch.dict(os.environ, {"MOCK_TEST_KEY": "12345"})
    def test_environment_variable_precedence(self):
        """Test that ENV variables are resolved first"""
        result = gfv_auth.fetch_secret("MOCK_TEST_KEY", "op://mock/reference")
        self.assertEqual(result, "12345")
        
    @patch('subprocess.run')
    def test_1password_fallback(self, mock_subprocess):
        """Test that 1Password is called when ENV doesn't exist"""
        if "MOCK_TEST_KEY" in os.environ:
            del os.environ["MOCK_TEST_KEY"]
            
        mock_result = MagicMock()
        mock_result.stdout = "mocked_op_secret123\n"
        mock_subprocess.return_value = mock_result
        
        result = gfv_auth.fetch_secret("MOCK_TEST_KEY", "op://mock/reference")
        self.assertEqual(result, "mocked_op_secret123")
        mock_subprocess.assert_called_with(["op", "read", "op://mock/reference"], capture_output=True, text=True, check=True)

    @patch('subprocess.run')
    def test_failure(self, mock_subprocess):
        """Test that missing secrets return None gracefully"""
        if "MOCK_TEST_KEY" in os.environ:
            del os.environ["MOCK_TEST_KEY"]
            
        import subprocess
        mock_subprocess.side_effect = subprocess.CalledProcessError(1, "cmd")
        
        result = gfv_auth.fetch_secret("MOCK_TEST_KEY", "op://mock/reference")
        self.assertIsNone(result)

if __name__ == '__main__':
    unittest.main()
